# frozen_string_literal: true

class Widget < ApplicationRecord
  # Callbacks
  before_destroy :destroy_children
  after_create :capitalize_name

  # Validations
  validates :name, { uniqueness: { case_sensitive: false } }

  # Associations
  belongs_to :user
  has_one :action
  has_one :reaction, through: :action

  def disactivate
    self.active = false
    self.save
  end

  def activate
    self.active = true
    self.save
  end

  private
    def capitalize_name
      self.name.capitalize!
      self.save
    end

    def destroy_children
      self.reaction&.destroy
      self.action&.destroy
    end
end

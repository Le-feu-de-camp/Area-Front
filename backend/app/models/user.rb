# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  first_name             :string           not null
#  last_name              :string           not null
#  email                  :string           not null
#  background             :string
#  admin                  :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#
class User < ApplicationRecord
  # Callbacks
  before_destroy :destroy_children

  # Validattions
  validates :email,
    format: { with: /(.+)@(.+)/, message: "Email invalid"  },
              uniqueness: { case_sensitive: false },
              length: { minimum: 4, maximum: 254 }

  # Associations
  has_many :widgets

  # Scope
  scope :administrators, -> { where(admin: true) }

  # Devise gem authentication
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[twitter google_oauth2],
         jwt_revocation_strategy: JwtDenylist


  def self.from_omniauth(auth)
    where(provider: auth.provider).find_or_create_by(p_uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token
      user.first_name = auth.info.first_name # assuming the user model has a username
      user.last_name = auth.info.last_name # assuming the user model has a username
      user.provider = auth.provider
      user.p_uid = auth.uid
      # user.image = auth.info.image # assuming the user model has an image
    end

  def destroy_children
    self.reaction&.destroy
    self.action&.destroy
  end
end

# frozen_string_literal: true

class EachDayActionCommand
  def initialize(attributs)
    @action_id = attributs["action_id"]
  end

  def to_h
    { action_id: @action_id }
  end
end

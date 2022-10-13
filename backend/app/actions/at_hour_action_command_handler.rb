# frozen_string_literal: true

class AtHourActionCommandHandler
  def initialize
  end

  def call(attributs)
    puts "At Hour Command Handler"

    time_info = HTTParty.get("https://api.timezonedb.com/v2.1/get-time-zone?key=MLW9WKV7JEUS&format=json&by=position&lat=44.8404&lng=-0.5805")

    target_time = attributs[:hour].to_time
    current_time = time_info["formatted"].to_time

    resultat = target_time < current_time

    # Widget_to_kill.append(attributs[:widget_id]) if resultat
    # Widget.find(attributs[:widget_id]).desactivate

    resultat
  end
end
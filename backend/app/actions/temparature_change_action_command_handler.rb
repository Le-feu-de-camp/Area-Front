# frozen_string_literal: true

class TemparatureChangeActionCommandHandler
  def initialize
  end

  def call(attributes)
    puts "Temparature Change Command Handler" unless Rails.env.test?

    begin
      url = "https://api.open-meteo.com/v1/forecast?latitude=#{attributes[:latitude]}&longitude=#{attributes[:longitude]}&current_weather=true"
      weather_info = HTTParty.get(url)
      current_temp = weather_info["current_weather"]["temperature"].to_f
      last_temp = attributes[:last_temp].to_f
    rescue NoMethodError
      puts "Error: OpenMeteo return null"
      return false
    end

    result = current_temp != last_temp

    if result
      puts "Temparature Changed: #{result}"
      action = Action.find(attributes[:action_id])
      action.options["last_temp"] = current_temp.to_s
      action.save
    end

    result
  end
end

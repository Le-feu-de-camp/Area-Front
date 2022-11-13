# frozen_string_literal: true

class WeatherChangeActionCommandHandler
  def initialize
  end

  def call(attributes, mocked_response = nil)
    puts "Weather Change Command Handler" unless Rails.env.test?

    begin
      url = "https://api.open-meteo.com/v1/forecast?latitude=#{attributes[:latitude]}&longitude=#{attributes[:longitude]}&current_weather=true"
      weather_info = mocked_response || HTTParty.get(url)
      current_weather = weather_info["current_weather"]["weathercode"].to_i
      last_weather = attributes[:last_weather].to_i
    rescue NoMethodError
      puts "Error: OpenMeteo return null"
      return false
    end

    result = current_weather != last_weather


    if result
      puts "Weather Changed: #{result}"
      action = Action.find(attributes[:action_id])
      action.options["last_weather"] = current_weather.to_s
      action.save
    end

    result
  end
end
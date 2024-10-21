# frozen_string_literal: true

# Parses weather data from the weather api to return current temperature and forecast
class WeatherParser

  def self.current_weather(weather_data)
    new(weather_data).current_weather
  end

  def self.forecast_weather(weather_data)
    new(weather_data).forecast_weather
  end

  def initialize(weather_data)
    @weather_data = weather_data
  end

  attr_reader :weather_data

  # parses out the current temperature from the weather data
  def current_weather
    raise 'WeatherParser.current_weather: Weather data was not received.' if weather_data['current'].nil?

    weather_data['current']['temperature_2m']
  end

  # parses out the forecast temperature by hour from the weather data
  # returns a hash with the time as the key and the temperature as the value
  def forecast_weather
    raise 'WeatherParser.forecast: Weather data was not received' if weather_data['hourly'].nil?

    weather_data['hourly']['time'].each_with_index.map do |time, index|
      { DateTime.parse(time).strftime('%F %H:%M') => weather_data['hourly']['temperature_2m'][index] }
    end.inject(:merge)
  end

end

require 'rails_helper'

RSpec.describe WeatherParser, type: :class do
  include_context 'mock response'

  describe 'parse current weather data' do
    it 'should return current temperature' do
      current_temperature = WeatherParser.current_weather(current_weather_data)
      expect(current_temperature).to eq(15)
    end

    it 'should raise error weather data was not received' do
      results = {}
      expect{ WeatherParser.current_weather(results) }
        .to raise_error('WeatherParser.current_weather: Weather data was not received.')
    end

  end

  describe 'parse forecast weather data' do
    it 'should return forecast temperature by hour as an array' do
      forecast_temperatures = WeatherParser.forecast_weather(forecast_weather_data)
      expect(forecast_temperatures.size).to eq(168)
      expect(forecast_temperatures.first).to eq(['2024-10-18 00:00', 49.3])
    end

    it 'should return empty array as empty hash' do
      results = {}
      expect { WeatherParser.forecast_weather(results) }.to raise_error('WeatherParser.forecast: Weather data was not received')
    end
  end


end

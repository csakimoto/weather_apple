require 'rails_helper'

RSpec.describe Client::Weather do
  include_context 'mock response'

  describe 'get_weather' do
    it 'should return weather current data' do
      coordinates = { latitude: 37.7749, longitude: 122.4194 }
      allow(Client::Weather).to receive(:request).with(:get, coordinates).and_return(current_weather_data)

      weather_data = Client::Weather.request(:get, coordinates)
      expect(weather_data).to be_present
      expect(weather_data['current']['temperature_2m']).to be_present
    end

    it 'should return weather forecast data' do
      coordinates = { latitude: 37.7749, longitude: 122.4194 }
      forecast = { forecast: true }
      allow(Client::Weather).to receive(:request).with(:get, coordinates, forecast).and_return(forecast_weather_data)

      weather_data = Client::Weather.request(:get, coordinates, forecast)
      expect(weather_data).to be_present
      expect(weather_data['hourly_units']).to be_present
    end

    it 'should return error' do
      coordinates = { latitude: 'a', longitude: 'b' }
      allow(Client::Weather).to receive(:request).with(:get, coordinates).and_raise(weather_error)

      expect{ Client::Weather.request(:get, coordinates)}.to raise_error(weather_error)
    end
  end
end
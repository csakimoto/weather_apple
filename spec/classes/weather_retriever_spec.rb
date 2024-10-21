require 'rails_helper'

RSpec.describe WeatherRetriever, type: :class do
  include_context 'mock response'

  describe 'weather_api' do
    it 'should return weather data' do
      params = { latitude: 37.7749, longitude: 122.4194 }
      allow(Client::Weather).to receive(:request).with(:get, params).and_return(current_weather_data)

      weather_data = Client::Weather.request(:get, params)
      expect(weather_data['current']['temperature_2m']).to eq(15)
    end

  end

  describe 'geolocation_data' do
    before(:each) do
      allow(Client::GoogleMaps).to receive(:request).with(:get, { address: address }).and_return(geolocation_data_usa)
    end

    it 'should return geolocation data' do
      geolocation_data = Client::GoogleMaps.request(:get, { address: address })
      expect(geolocation_data['results']).to be_present
      expect(geolocation_data['status']).to eq('OK')
    end

    it 'should return geolocation data and parse latitude and longitude coordinates' do
      geolocation_data = Client::GoogleMaps.request(:get, { address: address })

      expect(geolocation_data['results']).to be_present
      latitude = geolocation_data['results'][0]['geometry']['location']['lat']
      longitude = geolocation_data['results'][0]['geometry']['location']['lng']

      expect(latitude).to eq(43.6630725)
      expect(longitude).to eq(-116.6823667)
    end

    it 'should return geolocation data and parse zipcode' do
      geolocation_data = Client::GoogleMaps.request(:get, { address: address })
      zipcode = geolocation_data['results'][0]['address_components'].find do |component|
        component['types'].include?('postal_code')
      end ['long_name']
      expect(zipcode).to eq('83605')
    end

    it 'should raise error zipcode is not found' do
      allow(Client::GoogleMaps).to receive(:request).with(:get, { address: address }).and_return( geolocation_data_no_results )
      geolocation_data = Client::GoogleMaps.request(:get, { address: address })

      expect(geolocation_data['results']).to eq([])
      expect(geolocation_data['status']).to eq('ZERO_RESULTS')
    end
  end

  describe 'retrieve' do
    before(:each) do
      allow(Client::GoogleMaps).to receive(:request).with(:get, { address: address }).and_return(geolocation_data_usa)
    end

    it 'should return current data' do
      allow(Client::Weather).to receive(:request).with(:get, lat_lng, { forecast: false }).and_return(current_weather_data)

      weather_retriever = WeatherRetriever.new(address, false)
      expect(weather_retriever.retrieve).to be_present
    end

    it 'should return forecast data' do
      allow(Client::Weather).to receive(:request).with(:get, lat_lng, { forecast: true }).and_return(forecast_weather_data)

      weather_retriever = WeatherRetriever.new(address, true)
      expect(weather_retriever.retrieve).to be_present
    end

  end

  describe 'test redis' do
    it 'should save weather data to Redis and should be returned based on key' do
      allow(Client::Weather).to receive(:request).with(:get, lat_lng, { forecast: false } ).and_return(current_weather_data)
      allow(Client::GoogleMaps).to receive(:request).with(:get, { address: address }).and_return(geolocation_data_usa)
      forecast = false
      weather_retriever = WeatherRetriever.new(address, forecast)
      weather_retriever.retrieve
      expect($redis.get(weather_retriever.send(:redis_key))).to be_present
    end

  end
end

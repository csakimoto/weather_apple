require 'rails_helper'

RSpec.describe WeatherController, type: :controller do
  include_context 'mock response'

  describe '#temperature' do

    before(:each) do
      allow(Client::Weather).to receive(:request).with(:get, lat_lng, forecast: false).and_return(current_weather_data)
      allow(Client::GoogleMaps).to receive(:request).with(:get, { address: address }).and_return(geolocation_data_usa)
    end

    it 'renders current weather partial' do
      params = { weather: { address: address, forecast: false } }
      post :temperature, params: params, format: :turbo_stream

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Current')
    end

    it 'renders forecast weather partial' do
      params = { weather: { address: address, forecast: true } }
      post :temperature, params: params, format: :turbo_stream

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Forecast')
    end

    it 'return response as error as turbo stream' do
      params = { weather: { address: '', forecast: false } }
      expect { post :temperature, params: params, format: :turbo_stream }.to raise_error('Please enter address')
      expect(response.body).to include('<turbo-stream action="replace" target="error">')
    end
  end

end
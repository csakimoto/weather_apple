require 'rails_helper'

RSpec.describe Client::GoogleMaps do
  include_context 'mock response'
  describe 'get_weather' do
    it 'should return geolocation data' do
      allow(Client::GoogleMaps).to receive(:request).with(:get, { address: address }).and_return( geolocation_data_usa )

      geolocation = Client::GoogleMaps.request(:get, {address: address} )
      expect(geolocation['status']).to eq('OK')
      expect(geolocation).to be_present
    end

    it 'should return no results' do
      params = { address: 'abcdef' }
      allow(Client::GoogleMaps).to receive(:request).with(:get,  params ).and_return( geolocation_data_no_results )

      geolocation = Client::GoogleMaps.request(:get, params)
      expect(geolocation['status']).to eq('ZERO_RESULTS')
    end
  end
end
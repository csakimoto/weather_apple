require 'rails_helper'

RSpec.describe GeolocationParser, type: :class do
  include_context 'mock response'

  describe 'parse geolocation data tp retrieve zipcode from USA address' do

    it 'should return zip code for USA address' do
      zipcode = GeolocationParser.new(geolocation_data_usa).send(:zipcode)

      expect(zipcode).to eq('83605')
    end

    it 'should raise error no address found' do
      expect { GeolocationParser.new(geolocation_data_usa_no_zipcode).send(:zipcode) }.to raise_error('No zipcode found')
    end

    it 'should return true if USA address usa_address?' do
      expect(GeolocationParser.new(geolocation_data_usa).send(:usa_address?)).to eq(true)
    end

    it 'should return false if not USA address usa_address?' do
      expect(GeolocationParser.new(geolocation_data_foreign).send(:usa_address?)).to eq(false)
    end
  end

  describe 'parse geolocation data tp retrieve zipcode from non-USA city' do
    it 'should return city name' do
      results = GeolocationParser.new(geolocation_data_foreign).send(:city_name)
      expect(results).to eq('Amsterdam')
    end

    it 'should raise error no address found' do
      expect { GeolocationParser.new(geolocation_data_usa_no_city).send(:city_name) }.to raise_error('No city name found')
    end
  end

end

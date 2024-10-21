# frozen_string_literal: true

# parses the geolocation data from the google maps api to return coordinates and zipcode/city_name
class GeolocationParser
  attr_reader :geolocation_data

  def self.coordinates(geolocation_data)
    new(geolocation_data).coordinates
  end

  def self.redis_key(geolocation_data)
    new(geolocation_data).redis_key
  end

  def initialize(geolocation_data)
    @geolocation_data = geolocation_data
  end

  #  Parses coordinates from geolocation data from google maps api
  def coordinates
    {
      latitude: geolocation_data['results'][0]['geometry']['location']['lat'],
      longitude: geolocation_data['results'][0]['geometry']['location']['lng']
    }
  end

  # return zipcode or city_name for redis key
  # Foreign cities do not return a zipcode
  def redis_key
    usa_address? ? zipcode : city_name
  end

  private

  # Cities outside the USA will return the city name instead of zipcode
  # # If no city name is found, it will raise an error
  def city_name
    city_name = geolocation_data['results'][0]['address_components'].find do |component|
      return component['long_name'] if component['types'].include?('locality')
    end
    raise 'No city name found' if city_name.nil?
  end

  # Check if address is a USA address
  # If so we will use the zipcode, else we will use the city_name
  def usa_address?
    geolocation_data['results'][0]['address_components'].any? do |component|
      component['types'].include?('country') && component['short_name'] == 'US'
    end
  end

  # Parses zipcode from geolocation data of USA from google maps api
  # If no zipcode is found, it will raise an error
  def zipcode
    zipcode = geolocation_data['results'][0]['address_components'].find do |component|
      return component['long_name'] if component['types'].include?('postal_code')
    end
    raise 'No zipcode found' if zipcode.nil?
  end

end

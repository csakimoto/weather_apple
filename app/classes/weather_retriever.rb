# frozen_string_literal: true

# Description: This class is responsible for retrieving the weather data based on an address.
# Using Google Maps API to get coordinates and zipcode based on address and the OpenWeather API
class WeatherRetriever
  attr_reader :address, :forecast, :used_cache

  def self.retrieve(address, forecast)
    new(address, forecast).retrieve
  end

  def initialize(address, forecast)
    @address = address
    @forecast = forecast
    @used_cache = false
  end

  # If forecast is true return 7 day forecast, otherwise just return the current temperature
  def retrieve
    results = retrieve_weather
    raise 'Temperature/Forecast was not found for this address.' if results.blank?

    save_redis
    results
  end

  private

  # parse results from Google Maps API to get the coordinates
  def coordinates
    @coordinates ||= GeolocationParser.coordinates(geolocation_data)
  end

  # Parses weather data to get current temperature value
  def current_weather
    WeatherParser.current_weather(weather_data)
  end

  # Parses weather data to get forecast temperature values as a hash
  def forecast_weather
    WeatherParser.forecast_weather(weather_data)
  end

  # ping GoogleMaps API to retrieve geolocation data
  def geolocation_data
    @geolocation_data ||= begin
      data = Client::GoogleMaps.request(:get, { address: address })
      raise 'Address is not found.' if data.blank?

      data
    end
  end

  # Create redis key based on zipcode or city name
  # If forecast is true, append '-f' to the key
  def redis_key
    key = GeolocationParser.redis_key(geolocation_data)
    @redis_key ||= forecast ? "#{key}-f" : key
  end

  # get weather either from redis or ping weather api
  def retrieve_weather
    @retrieve_weather ||= if $redis.get(redis_key)
                            @used_cache = true
                            JSON.parse($redis.get(redis_key))
                          else
                            @used_cache = false
                            forecast ? forecast_weather : current_weather
                          end
  end

  # save the results in Redis based on zipcode and set expiration to be 1800 sec
  def save_redis
    $redis.set(redis_key, retrieve_weather.to_json, ex: 1800)
  end

  # ping open weather api to get weather based on coordinates [latitude, longitude]
  # Returns response from OpenMeteo API
  def weather_data
    @weather_data ||= begin
      data = Client::Weather.request(:get, coordinates, { forecast: forecast })
      raise 'Weather data is not found.' if data.blank?

      data
    end
  end

end

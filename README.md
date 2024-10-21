# Weather Apple: retrieve current temperature or 7-day forecast.

### Description
    Weather Apple is a simple web application that retrieves the current temperature or 7-day forecast for a given location.
    US address follow a typical US address format ex. 1 Infinite Loop Cupertino, CA or the application can accept and world city such as
    London, UK
    - There are no models in this application, as the data is retrieved from the Open-Meteo API and stored in Redis.
    - The application uses the open-meteo.com API to retrieve the weather data, and uses GoogleMpas to retrieve the Geolocation data.
    - The application uses Redis to store the weather data for a given location.

## Foundation
* Ruby: 3.0.0
* Rails: 7.0.8
* Chartkick
* Turbo frames

### Database: Redis
* Used to store the weather data for a given location.

### 3rd Party API
* Open-Meteo retrieves weather data:  https://open-meteo.com
* Google Maps retrieves geolocation data : https://developers.google.com/maps/documentation/geocoding/overview

### Testing
* RSpec: 3.9.0
* WebMock: 3.13.0
* MockRedis: 0.19.0
* How to run the test suite
  * rspec ./spec/*

## Installation
Make sure you have ruby 3.0.0 installed
* https://rvm.io/
* https://github.com/rbenv/rbenv
* bundle install
* yarn

## Controllers
* Weather controller
  * index
    * Loads default index page to enter address 
  * temperature
    * parameters weather: { address: '123 Main St. Boise, ID' , forecast: false }
      * Returns turbo frame current temperature partial if forecast is false
      * Returns turbo frame forecast line chart partial if forecast is true
      * Error turbo frame partial: renders if error is raised
  * clear_error: clears error turbo_frame

## Classes
* Directory Client contains the following classes:
  * base- base class for Faraday Client to ping 3rd Party APIs
    * GoogleMaps: retrieve geolocation data from google maps API. Requires an API_KEY
    * Weather: retrieve current temperature or forecast temperature data. No API_KEY required
      * URL is modified based on if forecast is true or false
* WeatherRetriever
  * Used to retrieve either current day/hr Temperature in F or 7-day forecast by day/hr°
  * Called using WeatherRetriever.retrieve(address, forecast). 
    * forecast boolean
    * address is a string
  * GoogleMaps API is pinged to geolocation data
  * Geolocation data is parsed to return latitude/longitude, and related zip code. This is done in GeolocationParser.
  * After latitude/longitude is returned, open-meteo API is pinged to get either forecast or current temperature.
  * Redis is checked for redis key if the current temperature or forecast has already been saved.
    * Redis key is set with zipcode for current weather or wth a '-f' for forecast. If this is a non-US city it will save the city name as the key
    * Redis data is good for 30 min.
  * If address zipcode or city is not in redis, the weather data from open-meteo is then parsed in WeatherParser to return the current temperature 
  * or 7-day forecast temperature for each hour.
* WeatherParser
  * current_weather: parses current weather value
  * forecast_weather: parses hash with '2023-10-20 08:00' => 76.2 for 7 days for each hour of the day
* GeolocationParser
  * coordinates: parses latitude and longitude for google maps geolocaton data
  * usa_address?: check if address is a USA address
  * redis_key: method called to set redis key based on city name or US zipcode
  * zipcode: parses geolocation data to retrieve a zipcode
  * city_name: parses geolocation data to retrieve a non USA city

## Views
* index.html.erb
  * contains
    * form_for
      * text_field :address
      * check_box :forecast
    * turbo_frame: error
      * shows error message
    * turbo_frame: temperature
      * shows either current partial or forecast partial
* _current.html.erb
  * Shows related entered address and current temperature 
* _forecast.html.erb
  * Renders LineChart of related address temperature data based on F° and Day/Hour

## Start App
* Compile assets: rake assets:precompile
* Start redis: redis-server
* RAILS_ENV=production bundle exec rails s -p 3000
* Go to localhost:3000 url

## Possible Improvements
* Could track address so we don't have to lookup address each time













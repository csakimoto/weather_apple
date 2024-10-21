# frozen_string_literal: true

# Google Maps Client using the Base Client to execute an http(s) request to the google maps api
module Client
  class GoogleMaps < Base
    API_KEY = Rails.application.credentials.google_maps_api_key

    private

    def url
      "https://maps.googleapis.com/maps/api/geocode/json?#{uri_encode_params}&key=#{API_KEY}"
    end
  end
end

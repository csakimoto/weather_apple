# frozen_string_literal: true

# Weather Client using the Base Client to execute an http(s) request to the open-meteo api
module Client
  class Weather < Base

    private

    # returns forecast url if options[:forecast] is true, otherwise returns current weather url
    def url
      if options[:forecast]
        "https://api.open-meteo.com/v1/forecast?#{uri_encode_params}&hourly=temperature_2m&temperature_unit=fahrenheit"
      else
        "https://api.open-meteo.com/v1/forecast?#{uri_encode_params}&current=temperature_2m&temperature_unit=fahrenheit"
      end
    end
  end
end


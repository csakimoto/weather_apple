# frozen_string_literal: true

# Base Client using Faraday to execute an http(s) request using a certain url, and http method
# Returns a parsed JSON response if there is successful response
module Client
  class Base
    attr_reader :http_method, :response, :params, :options

    def self.request(http_method, params = {}, options = {})
      new(http_method, params, options).request
    end

    def initialize(http_method, params = {}, options = {})
      @http_method = http_method
      @params = params
      @options = options
    end

    def request
      send_request
    end

    private

    def client
      @client ||= Faraday.new(url: url) do |cl|
        cl.request :url_encoded
        cl.adapter Faraday.default_adapter
      end
    end

    def send_request
      @response = client.public_send(http_method)
      raise "Client::Error Code: #{response.status}, response: #{response.body}" unless response_successful?

      JSON.parse(response.body)
    end

    def url
      raise NotImplementedError
    end

    def uri_encode_params
      URI.encode_www_form(params)
    end

    def response_successful?
      response.status == 200
    end
  end

end

# frozen_string_literal: true

# Controller to display index and to get temperature based on an address
class WeatherController < ApplicationController

  # Render default page
  def index
    render 'weather/index'
  end

  # Returns turbo stream with temperature or forecast based on address
  # If an error is raised a turbo stream with error message is returned
  def temperature
    begin
      raise 'Please enter address' if weather_params[:address].blank?

      # Used to display address in partials and to get weather data
      @address = weather_params[:address]
      @results = WeatherRetriever.retrieve(@address, forecast)
      raise 'Temperature/Forecast was not found for this address.' if @results.blank?

      # If forecast is true, render forecast partial, otherwise render current partial
      partial = forecast ? 'weather/forecast' : 'weather/current'

      render turbo_stream: turbo_stream.update('temperature', partial: partial, locals: { results: @results })

    rescue StandardError => e
      Rails.logger.error("Error: #{e.message}")
      render turbo_stream: turbo_stream.replace('error', partial: 'weather/error', locals: { error: e.message })
    end
  end

  # Clears error message
  def clear_error
    render turbo_stream: turbo_stream.remove('error')
  end

  private

  # Returns true if forecast is 1, otherwise false
  def forecast
    weather_params[:forecast] == '1'
  end

  # Returns weather params
  def weather_params
    params.require(:weather).permit(:address, :forecast)
  end
end

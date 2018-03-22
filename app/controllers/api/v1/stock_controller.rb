class Api::V1::StocksController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        symbol = 'AT'
        key = ENV['ALPHA_KEY']
        response = HTTParty.get(`https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=#{symbol}&outputsize=full&apikey=#{key}`)
        @stock = JSON.parse(response.body)
        render json: @stock
    end
end
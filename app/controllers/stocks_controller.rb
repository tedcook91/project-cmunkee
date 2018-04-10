require 'pry'

class StocksController < ApplicationController
    skip_before_action :verify_authenticity_token
    # before_action :set_stock, only: [:show]
    # def index
    #     symbol = 'AT'
    #     key = ENV['ALPHA_KEY']
    #     response = HTTParty.get(`https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=#{symbol}&outputsize=full&apikey=#{key}`)
    #     @stock = JSON.parse(response.body)
    #     render json: @stock
    # end

    def index
        @stocks = Stock.all
    end

    def new
        @stock = Stock.new
    end

    def create
        @stock = Stock.new(stock_params)
        @stock.save
        render :new
    end

    def show
      key = ENV['ALPHA_KEY']
      @stock = 'MSFT'
      stock_data = HTTParty.get("https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=#{@stock}&outputsize=full&apikey=#{key}")      
    end

end

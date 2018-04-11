require 'pry'

class StocksController < ApplicationController


    def index
        @stocks = Stock.all
    end

    def new
        @stock = Stock.new
    end

    def create
        @stock = Stock.new(stock_params)
        key = ENV['ALPHA_KEY']
        symbol = @stock.symbol
        date = @stock.date
        stock_data = HTTParty.get("https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=#{symbol}&outputsize=full&apikey=#{key}")      
        @close = stock_data["Time Series (Daily)"]["#{date}"]["4. close"]    
        render :show
    end

    def show
    end

    
    private
    
    def stock_params
    params.require(:stock).permit(:symbol, :date)
    end

end

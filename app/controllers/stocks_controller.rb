require 'nokogiri'
require 'pry'
require 'json'
require 'date'
require 'open-uri'



class StocksController < ApplicationController

    
    
    def index
        @stocks = Stock.all
    end

    def new
        @stock = Stock.new
    end

    def create
        @stocks = Stock.all
        @stocks.delete_all
       

        @stock = Stock.new(stock_params)
        key = ENV['ALPHA_KEY']
        symbol = @stock.symbol
        date = @stock.date
        
        stock_data = HTTParty.get("https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=#{symbol}&outputsize=full&apikey=#{key}")      
        @stock.close = stock_data["Time Series (Daily)"]["#{date}"]["4. close"]    

    page_source = open("https://finance.yahoo.com/quote/#{symbol}/profile").read

    parse_page = Nokogiri::HTML(page_source)

    @stock.name = parse_page.xpath('//section/div[1]/div/h3').text
    @stock.sector = parse_page.xpath('//section/div[1]/div/div/p[2]/strong[1]').text
    @stock.industry = parse_page.xpath('//section/div[1]/div/div/p[2]/strong[2]').text
    @stock.save

    @stocks = Stock.all
   
        render :show
    end

    def show
    end

    
    private
    
    def stock_params
    params.require(:stock).permit(:symbol, :date)
    end

end
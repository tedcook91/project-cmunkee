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

        @stock = Stock.new(stock_params)
        key = ENV['ALPHA_KEY']
        symbol = @stock.symbol
        symbols = symbol.split(',')
        
        
        date = @stock.date

        @symbol_array = []
        
        symbols.each do |s|
            
            puts "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=#{s}&outputsize=full&apikey=#{key}"

            stock_data = HTTParty.get("https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=#{s}&outputsize=full&apikey=#{key}")  
            
            
            
            
            @close = stock_data["Time Series (Daily)"]["#{date}"]["4. close"]   
             
            
            sleep 1.5

            page_source = open("https://finance.yahoo.com/quote/#{s}/profile").read
            
            parse_page = Nokogiri::HTML(page_source)
            
            @name = parse_page.xpath('//section/div[1]/div/h3').text
            @sector = parse_page.xpath('//section/div[1]/div/div/p[2]/strong[1]').text
            @industry = parse_page.xpath('//section/div[1]/div/div/p[2]/strong[2]').text
            
            
           @symbol_array << {'symbol': s, 'name': @name, 'date': date, 'close': @close, 'sector': @sector, 'industry': @industry}
            
        end
            
            @symbol_array.flatten!
        

        render :show
    end

    def show
    end

    
    private
    
    def stock_params
    params.require(:stock).permit(:symbol, :date)
    end

end
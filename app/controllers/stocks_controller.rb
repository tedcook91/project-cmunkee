require 'Nokogiri'
require 'pry'
require 'json'
require 'date'
require 'selenium-webdriver'
require 'dotenv/load'



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

    
        driver = Selenium::WebDriver.for :chrome
        
        driver.navigate.to "http://www.morningstar.com/stocks/xnys/#{symbol}/quote.html"
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        
        begin
            
            parse_page = Nokogiri::HTML(driver.page_source)
            
            @sector = parse_page.css('.sal-component-company-profile-body').css('.sal-snap-panel').css('.sal-dp-value').css('.sal-dp-value').css('.ng-binding')[0].text.strip
            @industry = parse_page.css('.sal-component-company-profile-body').css('.sal-snap-panel').css('.sal-dp-value').css('.sal-dp-value').css('.ng-binding')[1].text.strip
            
        ensure
            driver.quit
        end

        render :show
    end

    def show
    end

    
    private
    
    def stock_params
    params.require(:stock).permit(:symbol, :date)
    end

end
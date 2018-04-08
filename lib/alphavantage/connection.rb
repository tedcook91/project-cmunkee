require 'faraday'
require 'json'

class Connection
    BASE = 'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=#{symbol}&outputsize=full&apikey=#{key}'

    def self.api
        Faraday.new(url: BASE) do |faraday|
            faraday.response :logger
            faraday.adapter Faraday.default_adapter
            faraday.headers['Content-Type'] = 'application/json'
            faraday.headers['X-Alpha-Key' = ENV['ALPHA_KEY']
        end
    end
end
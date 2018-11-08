require 'httparty'

# Wrapper for CoinMarketCap API
module CoinMarketCapWrapper
  include HTTParty

  base_uri 'https://api.coinmarketcap.com/v2'

  def self.ticker(id, currency = 'USD')
    get("/ticker/#{id.strip}?convert=#{currency}")
  end
end

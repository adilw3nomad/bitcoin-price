require 'httparty'

# Wrapper for CoinMarketCap API
module CoinMarketCapWrapper
  class Ticker
    include HTTParty
    base_uri 'https://api.coinmarketcap.com/v2'

    attr_reader :currency, :crypto_id
    def initialize(opts={currency: 'USD'})
      @currency, @crypto_id = opts.values_at(:currency, :crypto_id).map{|arg| arg.gsub(' ', '')}
    end

    def price_info
      self.class.get("/ticker/#{crypto_id}?convert=#{currency}")
    end
  end
end

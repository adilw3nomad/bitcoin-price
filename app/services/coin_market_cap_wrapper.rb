require 'httparty'

# Wrapper for CoinMarketCap API
module CoinMarketCapWrapper
  include HTTParty

  base_uri 'https://api.coinmarketcap.com/v2'

  def self.ticker(id, currency = 'USD')
    get("/ticker/#{id.strip}?convert=#{currency}")
  end

  class Ticker
    attr_reader :currency, :crypto_id
    def initialize(opts)
      @currency, @crypto_id = opts.values_at(:currency, :crypto_id)
    end
  end
end

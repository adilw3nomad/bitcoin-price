require_relative '../spec_helper'

describe CoinMarketCapWrapper do
  it 'should include HTTParty methods' do
    CoinMarketCapWrapper.must_include HTTParty
  end

  it 'should have a base uri set to the CoinMarketCap API' do
    CoinMarketCapWrapper.base_uri.must_equal 'https://api.coinmarketcap.com/v2'
  end

  describe '#ticker' do
    it 'should receive a 200 response with a hash of details when called with a valid ID' do
      VCR.use_cassette('bitcoin_ticker_response') do
        response = CoinMarketCapWrapper.ticker '1'
        response.code.must_equal 200
        response['data'].must_be_instance_of Hash
      end
    end

    it 'should strip any whitespace from the id parameter' do
      VCR.use_cassette('bitcoin_ticker_response') do
        response = CoinMarketCapWrapper.ticker '1      '
        response.code.must_equal 200
      end
    end

    it 'should receive a 404 if called with an invalid ID' do
      VCR.use_cassette('non_existent_ticker_response') do
        response = CoinMarketCapWrapper.ticker '0'
        response.code.must_equal 404
        response['data'].must_be_nil
      end
    end

    it 'should have a currency parameter which defaults to USD' do
      VCR.use_cassette('bitcoin_ticker_response') do
        response = CoinMarketCapWrapper.ticker '1'
        response['data']['quotes'].keys.must_include 'USD'
      end
    end

    it 'should accept a currency code and return the quotes in that currency if available' do
      VCR.use_cassette('bitcoin_eur_ticker_response') do
        response = CoinMarketCapWrapper.ticker '1', 'EUR'
        response['data']['quotes'].keys.must_include 'EUR'
      end
    end
  end
end

require_relative '../spec_helper'

describe CoinMarketCapWrapper::Ticker do
  let(:bitcoin_gbp_ticker) { CoinMarketCapWrapper::Ticker.new(crypto_id: '1', currency: 'GBP') }
  let(:ticker) { CoinMarketCapWrapper::Ticker }
  
  describe 'default attributes' do 
    it 'should include HTTParty methods' do
      ticker.must_include HTTParty
    end
  
    it 'should have a base uri set to the CoinMarketCap API' do
      ticker.base_uri.must_equal 'https://api.coinmarketcap.com/v2'
    end
  end

  describe '.initialize' do
    it 'must have a currency code when initialised' do
      bitcoin_gbp_ticker.must_respond_to :currency
    end

    it 'must have the right currency code when initialised' do
      bitcoin_gbp_ticker.currency.must_equal 'GBP'
    end

    it 'must have a cryptocurrency id when initialised' do
      bitcoin_gbp_ticker.must_respond_to :crypto_id
    end

    it 'must have the right cryptocurrency id when initialised' do
      bitcoin_gbp_ticker.crypto_id.must_equal '1'
    end

    # Because we are making building URIs, we can't have spaces in query params
    it 'must strip any whitespace from arguments' do 
      ticker_args_have_whitespace = ticker.new(crypto_id: '    1', currency: '   G B P' )
      ticker_args_have_whitespace.crypto_id.must_equal '1'
      ticker_args_have_whitespace.currency.must_equal 'GBP'
    end
  end

  describe '#price_info' do
    it 'should receive a 200 response with a hash of details when called with a valid ID' do
      VCR.use_cassette('bitcoin_ticker_response', record: :new_episodes) do
        response = bitcoin_gbp_ticker.price_info
        response.code.must_equal 200
        response['data'].must_be_instance_of Hash
      end
    end
  

    it 'should receive a 404 if called with an invalid ID' do
      VCR.use_cassette('non_existent_ticker_response', record: :new_episodes) do
        response = ticker.new(crypto_id: '0', currency: 'USD').price_info
        response.code.must_equal 404
        response['data'].must_be_nil
      end
    end

    it 'should have a currency parameter which defaults to USD' do
      VCR.use_cassette('bitcoin_ticker_response') do
        response = ticker.new(crypto_id: '1', currency: 'USD').price_info
        response['data']['quotes'].keys.must_include 'USD'
      end
    end

    it 'should accept a currency code and return the quotes in that currency if available' do
      VCR.use_cassette('bitcoin_eur_ticker_response') do
        response = ticker.new(crypto_id: '1', currency: 'EUR').price_info
        response['data']['quotes'].keys.must_include 'EUR'
      end
    end
  end

  # describe '#ticker_data' do
  #   it 'must have a ticker_data method' do
  #     bitcoin_gbp_ticker.must_respond_to :ticker_data
  #   end
  # end
end

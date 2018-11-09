require_relative '../spec_helper'

describe CoinMarketCapWrapper::Ticker do
  let(:bitcoin_gbp_ticker) { CoinMarketCapWrapper::Ticker.new(crypto_id: '1', currency: 'GBP') }

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
  end
end

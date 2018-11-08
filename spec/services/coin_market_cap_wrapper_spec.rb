require_relative '../spec_helper'

describe CoinMarketCapWrapper do
  it 'should include HTTParty methods' do
    CoinMarketCap.must_include HTTParty
  end
end

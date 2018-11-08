require_relative '../spec_helper'

describe CryptoTicker do
  let(:bitcoin_gbp_ticker){ CryptoTicker.new(id: 1, currency: 'GBP') }
  before do 
    VCR.insert_cassette 'bitcoin_gbp_response', record: :new_episodes
  end

  after do 
    VCR.eject_cassette 
  end


  it 'must have a currency code when initialised' do 
    bitcoin_gbp_ticker.must_respond_to :currency
  end

  it 'must have the right currency code when initialised' do 
    bitcoin_gbp_ticker.currency.must_equal 'GBP'
  end


end
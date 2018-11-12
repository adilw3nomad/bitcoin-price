require 'sinatra/base'
require_relative '../services/coin_market_cap_wrapper'

class ApplicationController < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :views, proc{ File.join(root, '../views') }

  get '/' do
    erb :index
  end

  post '/price' do 
    ticker = CoinMarketCapWrapper::Ticker.new(crypto_id: '1', currency: params[:currency])
    price = ticker.quotes[ticker.currency]
    erb :show, :locals => {'price' => price, 'currency' => ticker.currency }
  end
end

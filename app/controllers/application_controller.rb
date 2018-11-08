require 'sinatra/base'
require_relative '../services/coin_market_cap_wrapper'
require_relative '../models/crypto_ticker'

class ApplicationController < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :views, proc { File.join(root, '../views') }

  get '/' do
    'hello world'
  end
end

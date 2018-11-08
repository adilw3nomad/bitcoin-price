require 'sinatra/base'
require_relative '../models/coin_market_cap_wrapper'

class ApplicationController < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :views, proc { File.join(root, '../views') }

  get '/' do
    'hello world'
  end
end

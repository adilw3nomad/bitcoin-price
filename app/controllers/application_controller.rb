require 'sinatra/base'

class ApplicationController < Sinatra::Base
  get "/" do
    "hello world"
  end
end
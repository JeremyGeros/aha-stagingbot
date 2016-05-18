require 'sinatra/base'

module AhaStagingbot
  class Web < Sinatra::Base
    get '/' do
      'Hi!'
    end
  end
end

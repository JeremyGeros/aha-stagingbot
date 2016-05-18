require 'sinatra/base'
module AhaStagingbot
  class Web < Sinatra::Base
    get '/' do
      'Hi!'
    end
    
    post '/staging-deploy' do
      if params['token'] == ENV['CAPISTRANO_TOKEN']
        server = Server.find_by(name: params['server'])
        user = map_git_name_to_slack(params['user'])
        
        if server 
          if server.claimed
            server.update(
              claimed: true, 
              claimed_by: user, 
              claimed_at: Time.now, 
              claimed_for: params['claimed_for'] + " taken from #{server.claimed_by}", 
              auto_claimed: true
            ) if server.claimed_by != user
          else
            server.update(
              claimed: true, 
              claimed_by: user, 
              claimed_at: Time.now, 
              claimed_for: params['claimed_for'], 
              auto_claimed: true
            )
          end
        end
      end
      'Thanks'
    end
    
    
    
    def map_git_name_to_slack(git)
      case git
      when 'k1w1'
        'Chris Waters'
      else
        git
      end
    end
  end
end

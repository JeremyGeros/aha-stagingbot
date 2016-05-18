module AhaStagingbot
  module Commands
    class Claim < SlackRubyBot::Commands::Base
      command 'claim' do |client, data, _match|
        name = data.text.gsub('stagingbot claim', '').strip
        server = Server.find_by(name: name)

        username = client.web_client.users_info(user: data.user).user.real_name

        if server
          if server.claimed
            if server.claimed_by == username
              client.say(channel: data.channel, text: "You've already claimed #{name}!")
            else
              client.say(channel: data.channel, text: "Sorry, #{name} is already reserved by #{username}.")
            end
          else
            server.update(status: true, claimed_by: username, claimed_at: Time.now)
            client.say(channel: data.channel, text: "Got it! You've reserved #{name}.")
          end
        else
          client.say(channel: data.channel, text: "I don't recognize server '#{name}'.")
        end
      end
    end
  end
end

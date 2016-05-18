module AhaStagingbot
  module Commands
    class Release < SlackRubyBot::Commands::Base
      command 'release' do |client, data|
        name = data.text.gsub(/^(stagingbot|sb)?(\s)?release/).strip
        forced = name.include?('force')
        name = name.gsub('force', '').strip

        server = Server.find_by(name: name)

        username = client.web_client.users_info(user: data.user).user.real_name

        if server
          if server.claimed
            if server.claimed_by == username || forced
              server.update(claimed: false, claimed_by: nil, claimed_at: nil)
              client.say(channel: data.channel, text: "Got it! #{name} is now released.")
            else
              client.say(channel: data.channel, text: "#{name} was reserved by #{username} (run `stagingbot release #{name} force` to force-release).")
            end
          else
            client.say(channel: data.channel, text: "#{name} is already unclaimed.")
          end
        else
          client.say(channel: data.channel, text: "I don't recognize server '#{name}'.")
        end
      end
    end
  end
end

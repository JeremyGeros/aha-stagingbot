module AhaStagingbot
  module Commands
    class Claim < SlackRubyBot::Commands::Base
      command 'claim' do |client, data|
        commands = data.text.gsub(/^(stagingbot|sb)?(\s)?claim/, '').strip.split(' ')
        name = commands.first
        server = Server.find_by(name: name)

        username = client.web_client.users_info(user: data.user).user.real_name

        if server
          if server.claimed && !server.auto_claimed
            if server.claimed_by == username
              client.say(channel: data.channel, text: "You've already claimed #{name}!")
            else
              client.say(channel: data.channel, text: "Sorry, #{name} is already reserved by #{server.claimed_by}.")
            end
          else
            if commands.length > 1
              commands.shift
              claimed_for = commands.join(' ')
              server.update(claimed: true, claimed_by: username, claimed_at: Time.now, claimed_for: claimed_for, auto_claimed: false)
              client.say(channel: data.channel, text: "Got it! You've reserved #{name} for #{claimed_for}.")
            else
              server.update(claimed: true, claimed_by: username, claimed_at: Time.now, auto_claimed: false)
              client.say(channel: data.channel, text: "Got it! You've reserved #{name}.")
            end
          end
        else
          client.say(channel: data.channel, text: "I don't recognize server '#{name}'.")
        end
      end
    end
  end
end

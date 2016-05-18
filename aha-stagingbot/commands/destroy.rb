module AhaStagingbot
  module Commands
    class Destroy < SlackRubyBot::Commands::Base
      command 'destroy' do |client, data|
        name = data.text.gsub(/^(stagingbot|sb)?(\s)?destroy/, '').strip
        server = Server.find_by(name: name)

        if server
          server.destroy
          client.say(channel: data.channel, text: "Server #{name} destroyed!")
        else
          client.say(channel: data.channel, text: "Server #{name} does not exist!")
        end
      end
    end
  end
end

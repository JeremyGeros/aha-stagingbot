module AhaStagingbot
  module Commands
    class Create < SlackRubyBot::Commands::Base
      command 'create' do |client, data|
        name = data.text.gsub(/^(stagingbot|sb)?(\s)?create/, '').strip

        if Server.exists?(name: name)
          client.say(channel: data.channel, text: "Server #{name} already exists!")
        else
          Server.create(name: name, claimed: false)
          client.say(channel: data.channel, text: "Server #{name} created!")
        end
      end
    end
  end
end

module AhaStagingbot
  module Commands
    class Create < SlackRubyBot::Commands::Base
      command 'create' do |client, data, _match|
        name = data.text.gsub('stagingbot create', '').gsub('sb create', '').strip

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

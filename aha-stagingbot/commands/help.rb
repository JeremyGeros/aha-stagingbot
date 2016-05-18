module AhaStagingbot
  module Commands
    class Help < SlackRubyBot::Commands::Base
      command 'help' do |client, data|
        commands = [
          {
            title: 'stagingbot list',
            text: 'Lists staging servers with status'
          },
          {
            title: 'stagingbot claim <name> <branch_or_reason>',
            text: 'Claims the staging server with the provided name'
          },
          {
            title: 'stagingbot release <name>',
            text: 'Releases the staging server with the provided name.'
          }
        ]

        client.web_client.chat_postMessage(channel: data.channel, text: 'StagingBot helps track available staging environments. Commands:', attachments: commands, as_user: true)
      end
    end
  end
end

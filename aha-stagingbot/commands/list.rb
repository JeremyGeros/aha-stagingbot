module AhaStagingbot
  module Commands
    class List < SlackRubyBot::Commands::Base
      command 'list' do |client, data|
        server_list = Server.all.order(:name).map do |server|
          text =
            if server.claimed
              if server.claimed_for && server.claimed_for != ''
                "Claimed by #{server.claimed_by} for #{time_diff(Time.now, server.claimed_at)} -- #{server.claimed_for}"
              else
                "Claimed by #{server.claimed_by} for #{time_diff(Time.now, server.claimed_at)}"
              end
            else
              'Unclaimed'
            end
          {
            title: server.name,
            text: text,
            color: server.claimed ? '#FF0000' : '#00FF00'
          }
        end

        client.web_client.chat_postMessage(channel: data.channel, attachments: server_list, as_user: true)
      end

      private

      class << self
        def time_diff(start_time, end_time)
          seconds_diff = (start_time - end_time).to_i.abs

          hours = seconds_diff / 3600
          seconds_diff -= hours * 3600

          minutes = seconds_diff / 60

          "#{hours} hours, #{minutes} minutes"
        end
      end
    end
  end
end

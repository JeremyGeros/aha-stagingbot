require 'slack-ruby-bot'
require_relative 'aha-stagingbot/model'
require_relative 'aha-stagingbot/commands/claim'
require_relative 'aha-stagingbot/commands/create'
require_relative 'aha-stagingbot/commands/destroy'
require_relative 'aha-stagingbot/commands/help'
require_relative 'aha-stagingbot/commands/list'
require_relative 'aha-stagingbot/commands/release'

SlackRubyBot.configure do |config|
  config.aliases = ['sb']
  config.send_gifs = false
end

module AhaStagingbot
  class Bot < SlackRubyBot::Bot
  end
end

AhaStagingbot::Bot.run

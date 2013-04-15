require 'cinch'
require "restclient"
require "nokogiri"
require "time"

module Selbot2
  PREFIX = ":"
  CHANNELS = Array(ENV['SELBOT_CHANNEL'])
  HELPS = []
end

require 'selbot2/log'

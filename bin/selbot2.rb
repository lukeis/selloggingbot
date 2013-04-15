#!/usr/bin/env ruby

require 'selbot2'

Cinch::Bot.new {
  configure do |c|
    c.server = "irc.freenode.net"
    c.nick   = "selloggingbot"
    c.channels = Selbot2::CHANNELS
    c.plugins.plugins = [
      Selbot2::Log,
    ]
  end

}.start


#!/usr/bin/env ruby

require 'selbot2'

Cinch::Bot.new {
  configure do |c|
    c.server = "irc.freenode.net"
    c.nick   = "ios-driverbot"
    c.channels = Selbot2::CHANNELS
    c.plugins.plugins = [
      Selbot2::Issues,
      Selbot2::Revisions,
      #Selbot2::Wiki,
      Selbot2::Youtube,
      Selbot2::Notes,
      Selbot2::Seen,
#      Selbot2::SeleniumHQ,
#      Selbot2::CI,
      Selbot2::Google,
      Selbot2::Log,
#      Selbot2::WhoBrokeIt
    ]

    # if File.exist?("twitter.conf")
    #   c.plugins.plugins << Selbot2::Twitter
    # end
  end

  Selbot2::HELPS << [':help', "you're looking at it"]
  on :message, /:help/ do |m|
    helps = Selbot2::HELPS.sort_by { |e| e[0] }
    just = helps.map { |e| e[0].length }.max

    helps.each do |command, help|
      m.user.privmsg "#{command.ljust just} - #{help}"
    end
  end

  Selbot2::HELPS << [':log', "link to today's chat log"]
  on :message, /:log/ do |m|
    m.reply "https://raw.github.com/ios-driver/irc-logs/master/#{(Time.new).strftime('%Y/%m/%d')}.txt"
  end

  [
    {
      :expression => /:newissue/,
      :text       => "https://github.com/ios-driver/ios-driver/issues",
      :help       => "link to issue the tracker"
    },
    {
      :expression => /:(source|code)/,
      :text       => "https://github.com/ios-driver/ios-driver",
      :help       => "link to the source code"
    },
    {
      :expression => /:docs/,
      :text       => "http://ios-driver.github.com/ios-driver/",
      :help       => "links to docs"
    },
    {
      :expression => /:gist/,
      :text       => "Please paste >3 lines of text to https://gist.github.com",
      :help       => "link to gist.github.com",
    },
    {
      :expression => /:ask/,
      :text       => "If you have a question, please just ask it. Don't look for topic experts. Don't ask to ask. Don't PM. Don't ask if people are awake, or in the mood to help. Just ask the question straight out, and stick around. We'll get to it eventually :)",
      :help       => "Don't ask to ask."
    },
    {
      :expression => /:(mailing)?lists?/,
      :text       => "https://groups.google.com/forum/#!forum/ios-driver",
      :help       => "link to mailing lists"
    },
    {
      :expression => /:(testcase|repro|example|sscce)/i,
      :text       => "Please read http://sscce.org/",
      :help       => "Link to 'Short, Self Contained, Correct (Compilable), Example' site"
    },
  ].each do |cmd|
    Selbot2::HELPS << [cmd[:expression].source, cmd[:help]]
    on(:message, cmd[:expression]) { |m| m.reply cmd[:text] }
  end

}.start


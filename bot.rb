
require 'cinch'
require 'sequel'
require 'logger'

require './config/config.rb'
puts CONFIG.inspect

DB = Sequel.connect(CONFIG["db"])

=begin
require 'sequel'
DB = Sequel.connect('sqlite://log.db')

M = DB[:messages]
=end

Sequel.extension :migration
Sequel::Migrator.check_current(DB, 'migrations')


class Message < Sequel::Model
end


bot = Cinch::Bot.new do
  configure do |c|
    c.server = CONFIG["server"]
    c.channels = CONFIG["channels"].split(",")
    c.nick = CONFIG["nick"]
  end

  helpers do
    def register_part_join(m)
      x = Message.new
      x.channel = m.channel.name
      x.nick = m.user.nick
      x.message = "#{x.nick} has joined"
      x.created = DateTime.now
      x.normal = false;
      x.save
    end
  end

  on :join do |m|
    register_part_join(m)
  end

  on :part do |m|
    register_part_join(m)
  end

  on :message, "+bot hello" do |m|
    m.reply("Hello")
  end

  on :message, "+bot privhello" do |m|
    m.user.send("Hello, privately")
  end

  on :message do |m|
    x = Message.new
    x.channel = m.channel.name
    x.nick = m.user.nick
    x.message = m.message
    x.created = DateTime.now
    x.normal = true
    x.save
  end
end

bot.start


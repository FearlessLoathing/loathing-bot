require 'cinch'

require 'sequel'
require 'logger'

DB = Sequel.connect('sqlite://log.db')

=begin
require 'sequel'
DB = Sequel.connect('sqlite://log.db')

M = DB[:messages]
=end

if !DB.table_exists?(:messages)
  DB.create_table :messages do
    primary_key :id
    String :channel
    String :nick
    String :message
    DateTime :created
    Boolean :normal
  end
end

class Message < Sequel::Model
end


bot = Cinch::Bot.new do
  configure do |c|
    c.server = "aamis.tk"
    c.channels = ["#bots"]
    c.nick = "loathing_bot"
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


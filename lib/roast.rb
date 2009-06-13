#!/usr/local/bin/ruby

require 'rubygems'
require 'yaml'
require 'optparse'
require 'tinder'

include Tinder

class Roast

  def self.main(first_msg=nil)
    
    config_file = YAML.load_file(ENV['HOME'] + '/roast.yml')

    options = Hash.new
    options[:room] = config_file["default"]

    opts = OptionParser.new do |opt|
      opt.banner = "Usage: roast [options] message"
      opt.separator ""
      opt.separator "Specific options:"
  
      opt.on("-r", "--room [room config]",
                 "Room name from config") do |room|
        options[:room] = room
      end
    end

    opts.parse!(ARGV)

    puts options.inspect

    conf = config_file[options[:room]]

    msg = first_msg || ARGV[0] || STDIN.read

    puts "Using #{conf['room']} configuration ..."

    campfire = Campfire.new(conf['domain'], :ssl => conf['ssl'])

    puts "Logging in..."
    campfire.login conf['username'], conf['password']
    puts "Logged in!"

    room = campfire.find_room_by_name conf["room"]

    puts "Joining #{room.name}..."
    room.join(true)
    puts "Entered room #{room.name}"

    puts "Saying message..."

    if msg.split("\n").size > 1
      room.paste(msg)
    else
      room.speak(msg)
    end

    puts "Leaving room..."

    room.leave

    puts "Done."

    exit
  end
end

class Object
  def to_roast
    msg = if self.is_a?(String)
      self
    else
      self.inspect.to_s
    end
    Roast.main(msg)
  end
end
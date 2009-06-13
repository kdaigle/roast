#!/usr/local/bin/ruby

require 'rubygems'
require 'tinder'
require 'yaml'

include Tinder

msg = ARGV[0] || STDIN.read

conf = YAML.load_file(ENV['HOME'] + '/roast.yml')['development']

# puts "Available chats:"
# @chats.keys.each_with_index do |key, index|
  # puts "(#{index}) #{key}"
# end

# chat_index = gets.strip.to_i || 0

# conf = @chats.values[chat_index]

# chat_name = @chats.keys[chat_index]


puts "Joining #{conf['room']} ..."


campfire = Campfire.new(conf['domain'], :ssl => conf['ssl'])

puts "Logging in..."
campfire.login conf['username'], conf['password']
puts "Logged in!"

# unless conf['default-room']
#   puts "Available rooms:"
# 
#   campfire.rooms.each_with_index do |room, index|
#     puts "(#{index}) #{room.name}"
#   end
# 
#   puts "Join which one?"
#   room = campfire.rooms[room_index]
# else
  room = campfire.find_room_by_name conf["room"]
# end

puts "Joining #{room.name} ..."
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
#!/usr/local/bin/ruby

require 'rubygems'
require 'tinder'
require 'yaml'

include Tinder

msg = ARGV[0]

@conf = YAML.load_file(ENV['HOME'] + '/roast.yml')

# puts "Available chats:"
# @chats.keys.each_with_index do |key, index|
  # puts "(#{index}) #{key}"
# end

puts "Which one do you want to join?"

# chat_index = gets.strip.to_i || 0

# conf = @chats.values[chat_index]

# chat_name = @chats.keys[chat_index]


puts "Joining #{conf['room']} ..."


campfire = Campfire.new conf['domain'], :ssl => conf['ssl']

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

room.speak(msg)

puts "Saying message..."

room.leave

puts "Leaving room..."

exit
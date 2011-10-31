module Roast

  class Main
    include Tinder

    attr_accessor :message, :room, :config, :domain, :ssl, :username, :password, :verbose

    def initialize(options)
      @message = options[:message]
      @config = YAML.load_file(ENV['HOME'] + '/roast.yml')
      room_config = @config[(options[:room] ? options[:room].to_s : @config["default"])]
      @room = room_config['room']
      @domain = room_config['domain']
      @ssl = room_config['ssl']
      @username = room_config['username']
      @password = room_config['password']
      @verbose = options[:verbose]
      self
    end

    def self.run(options={})

      opts = OptionParser.new do |opt|
        opt.banner = "Usage: roast [options] message"
        opt.separator ""
        opt.separator "Specific options:"

        opt.on("-r", "--room [room config]",
                   "Room name from config") do |room|
          options[:room] = room
        end
        opt.on("-v", "--verbose",
                   "Be verbose during the posting of the message") do |verbose|
          options[:verbose] = true
        end
      end

      opts.parse!(ARGV)

      roast = Roast::Main.new(options)

      roast.vocalize "Using #{roast.room} configuration ..."

      campfire = Campfire.new(roast.domain, :ssl => roast.ssl)

      roast.vocalize "Logging in..."
      campfire.login(roast.username, roast.password)
      roast.vocalize "Logged in!"

      room = campfire.find_room_by_name(roast.room)

      roast.vocalize "Joining #{room.name}..."
      roast.vocalize "Entered room #{room.name}"

      roast.vocalize "Saying message..."

      if message_long?(options[:message])
        room.paste(options[:message])
      else
        room.speak(options[:message])
      end

      roast.vocalize "Leaving room..."

      roast.vocalize "Done."
    end

    def vocalize(message)
      STDOUT.puts message if self.verbose
    end

  private

    def self.message_long?(message)
      (message.split("\n").size > 1) || (message.size >= 255)
    end

  end

end
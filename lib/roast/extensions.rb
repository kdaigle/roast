class Object
  def roast(room=nil)
    msg = if self.is_a?(String)
      self
    else
      self.inspect.to_s
    end
    Roast::Main.run(msg, room)
  end
end
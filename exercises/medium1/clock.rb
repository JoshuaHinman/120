class Clock
  def initialize(hour, minute, seconds)
   set_time(hour, minute, seconds)
  end

  def set_time(hour, minute, seconds)
   self.hour = hour
   self.minute = minute
   self.seconds = seconds
  end

  def show_time
    puts format('%02d:%02d:%02d', hour,minute,seconds)
  end

  protected
  attr_accessor :hour, :minute, :seconds

  def inc
    hour += 1
  end
end

c= Clock.new(3, 30, 12)
c.show_time

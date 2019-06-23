class MainLoopTick
  TICK = {
    time: 60,
    time: 5,
    tick: MainLoopTick.new,
  }

  def self.current
    TICK.f :tick
  end

  def tick!
    time = TICK.f :time
    sleep time # temporary implementation # I need another thread (or fiber #optimization) for this
  end
end

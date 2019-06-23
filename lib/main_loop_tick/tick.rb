class MainLoopTick
  TICK = {
    # time: 60,
    time: 30,
    tick: MainLoopTick.new,
  }

  def self.current
    TICK.f :tick
  end

  def end_tick!
    time = TICK.f :time
    sleep time # temporary implementation # I need another thread (or fiber #optimization) for this
  end
end

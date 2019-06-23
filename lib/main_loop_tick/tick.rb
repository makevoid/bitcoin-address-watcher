class MainLoopTick

  TICK_TIME_ENV = ENV["TICK_TIME"] && ENV["TICK_TIME"].to_i

  TICK = {
    # time: 60,
    time: TICK_TIME_ENV || TICK_TIME_DEFAULT,
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

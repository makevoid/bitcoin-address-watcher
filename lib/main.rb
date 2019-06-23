
class Main

  def self.run!
    # bootstrap
    define_at_exit_hook!

    # main loop
    loop do
      count_init!

      send_notification = true
      # send_notification = false

      ADDRS.each do |address|
        notify_on_balance_update! address: address
      end

      end_tick!
    end
  end

  def self.end_tick!
    MainLoopTick.current.end_tick!
  end
end

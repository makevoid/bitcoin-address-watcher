
class Main

  # TODO: config
  ADDRS = [
    "39koh3e6NsesfUxgXvwX1AuLegr93ZQBnj",
    "3BLtCbn2LwVcLYCf2fU2oNRPnodgBMr5PH",
  ]

  def self.run!
    # bootstrap
    define_at_exit_hook!

    # main loop
    loop do
      count_init!

      send_notification = true
      # send_notification = false

      ADDRS.each do |address|
        notify_on_new_transactions! address: address
      end

      cycle_sleep!
    end
  end

  def self.cycle_sleep!
    MainLoopTick.current.tick!
  end
end

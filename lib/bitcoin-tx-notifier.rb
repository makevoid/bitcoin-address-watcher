require_relative 'env'

require_relative 'state'

def define_at_exit_hook!
  at_exit do
    puts "EXIT!"
    # push_notification "exit"
  end
end

include PushNotifications

MESSAGES = {
  tx: "
    You have a new transaction!
  ".strip,
  conf: "
    That transaction confirmed! You can spend the BTCs!
  ".strip,

}

def notify!(stats, message: MESSAGES.f(:tx))
  puts "(push notif.)"

  address           = stats.f :address
  balance           = stats.f :balance
  balance_zeroconf  = stats.f :balance_zeroconf
  tx_count          = stats.f :tx_count
  tx_zeroconf_count = stats.f :tx_zeroconf_count


  balances  = "bal: #{balance} / zeroconf-bal: #{balance_zeroconf}"
  tx_counts = "txs: #{tx_count} / zeroconf-txs: #{tx_zeroconf_count}"
  push_notification "#{message} - #{address} - #{balances} - #{tx_counts}"
end

def count_init!
  DB[:count] = 0
end

def count_update
  DB[:count] = DB[:count] + 1
end

def stats_prev_get
  DB[:stats]
end

def stats_save(stats)
  DB[:stats] = stats
end

def get_address(address)
  addr = Address.get address
  # p addr
  {
    address:            address,
    balance:            addr.f("balance"),
    balance_zeroconf:   addr.f("unconfirmed_balance"),
    tx_count:           addr.f("final_n_tx"),
    tx_zeroconf_count:  addr.f("unconfirmed_n_tx"),
  }
end

def stats_diff?(stats:, stats_prev:)
  return unless stats[:balance]
  return unless stats_prev[:balance]
  return false if DB.f(:stats)[:empty]
  stats.f(:balance) > stats_prev.f(:balance) ||
    stats.f(:balance_zeroconf) > stats_prev.f(:balance_zeroconf)
end

def notify_on_balance_update!(address:)
  stats_prev = stats_prev_get

  stats = get_address address
  sleep 0.5 # to slow down requests when getting a big number of addresses

  puts "Stats:"
  p stats
  puts
  # p stats_prev
  # puts
  # stats = { balance: ... , antani: ... }

  stats_save stats

  if stats_diff? stats: stats, stats_prev: stats_prev
  # if true
    puts "Trigger"
    notify! stats

  end

  puts "---\n\n"
end


require_relative 'main'

# main loop
Main.run!

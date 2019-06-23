require_relative 'env'

require_relative 'state'

def define_at_exit_hook!
  at_exit do
    puts "EXIT!"
    # push_notification "exit"
  end
end

include PushNotifications

def notify!(tx)
  puts "TX Received! (push notif.)"
  conf    = tx.f :conf
  tx_id   = tx.f :tx_id_short
  address = tx.f :addr
  if conf == 0
    push_notification "0 confs - #{address} - BTC TX #1 Received  - value: #{} - tx: #{tx_id}"
  else
    push_notification "#{conf} confs - #{address} - BTC TX #1 Confirmed - tx: #{tx_id}"
  end
end

def count_init!
  DB[:count] = 0
end

def count_update
  DB[:count] = DB[:count] + 1
end

def transaction_exists?(transaction)
  DB[:transactions].find do |tx|
    id = tx.f :id
    transaction.f(:id) == id
  end
end

def append_transaction(tx)
  DB[:transactions] << tx
end

def get_address(address)
  addr = Address.get address

  {
    balance:            addr.f("balance"),
    balance_zeroconf:   addr.f("unconfirmed_balance"),
    tx_count:           addr.f("final_n_tx"),
    tx_zeroconf_count:  addr.f("unconfirmed_n_tx"),
  }
end

def get_transactions(address:)
  tx = TX.get address: address

  txs = tx.f "txrefs"
  txs.each{ |tx| tx["is_confirmed"] = true }
  zeroconf_txs = tx["unconfirmed_txrefs"] || []
  zeroconf_txs.each{ |tx| tx["is_confirmed"] = false }

  transactions = txs + zeroconf_txs
  tx_info = {
    balance:          tx.f("balance"),
    balance_zeroconf: tx.f("unconfirmed_balance"),
  }

  {
    transactions: transactions,
    meta: tx_info,
  }
end

def conf_num_changed?(tx:, tx_old:)
  conf_old = tx_old.f :conf
  conf_new = tx.f :conf
  conf_new > conf_old && conf_new < 2
end

def build_transaction(tx:, address:, tx_info:)
  tx_hash = tx.f "tx_hash"
  value   = tx.f "value"
  value_bits = (value.to_f / 100).floor
  meta = {
    value_bits:       value_bits,
    tx_id_short:      tx_hash[0..6],
    last_checked_at:  Time.now,
    confirmed_at:     tx["confirmed"],
    confirmed:        tx.f("is_confirmed"),
    addr_balance:     tx_info.f(:balance),
    addr_balance_zeroconf: tx_info.f(:balance_zeroconf),
  }

  {
    idx:   0,
    id:    tx_hash,
    value: value,
    conf:  tx.f("confirmations"),
    addr:  address,
    meta:  meta,
  }
end

def notify_on_balance_update!(address:)

end

def notify_on_new_transactions!(address:)
  transactions = get_transactions address: address

  addr_details = transactions.f :meta
  tx_info = {
    balance:          addr_details.f(:balance),
    balance_zeroconf: addr_details.f(:balance_zeroconf),
  }
  transactions = transactions.f :transactions


  puts "Transactions:"
  p transactions

  transactions.each do |tx|

    # tx = transactions.first

    transaction = build_transaction tx: tx, address: address, tx_info: tx_info

    puts "Transction:"
    p transaction.inspect
    puts

    append_transaction transaction

    unless old_tx = transaction_exists?(transaction)
      notify! transaction
    else
      if conf_num_changed? tx: transaction, tx_old: old_tx
        notify! transaction
      end
    end
  end

  puts "---\n\n"
end

require_relative 'main'

# main loop
Main.run!

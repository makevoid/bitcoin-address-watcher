require_relative 'env'

require_relative 'state'

def push_notification(message)
  Push.p message
end

at_exit do
  puts "EXIT!"
  # push_notification "exit"
end

def notify!(tx)
  puts "TX Received! (push notif.)"
  conf = tx.f :conf
  tx_id = tx.f :tx_id_short
  if conf == 0
    push_notification "0 confs - 3antani - BTC TX #1 Received  - value: #{} - tx: #{tx_id}"
  else
    push_notification "#{conf} confs - 3antani - BTC TX #1 Confirmed - tx: #{tx_id}"
  end
end

def count_init
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

def get_transactions(address:)
  UTXO.get address: address
end

def conf_num_changed?(tx_old:, tx_new:)

end

def notify_on_new_transactions!(address:)
  transactions = get_transactions address: address

  tx = transactions.first

  puts "Transction:"
  p tx.inspect
  puts

  tx_hash = tx.f "tx_hash"
  value   = tx.f "value"
  value_bits = (value.to_f / 100).floor

  transaction = {
    idx:   0,
    id:    tx_hash,
    value: value,
    conf:  tx.f("confirmations"),
    addr:  address,
    value_bits: value_bits,
    tx_id_short: tx_hash[0..6],
    last_checked_at: Time.now,
  }

  unless old_tx = transaction_exists? transaction
    append_transaction transaction

    # # raise DB[:transactions].inspect
    # transaction_id = transaction

    notify! transaction
  else
    if conf_num_changed? tx: transaction, tx_old: old_tx
      notify! transaction
    end
  end
end

ADDRS = [
  "39koh3e6NsesfUxgXvwX1AuLegr93ZQBnj",
]

loop do
  count_init
  send_notification = true
  # send_notification = false

  ADDRS.each do  |address|
    notify_on_new_transactions! address: address
  end

  sleep 3
  # sleep 60
end

require_relative 'env'

require_relative 'state'

def push_notification(message)
  Push.p message
end

at_exit do
  puts "EXIT!"
  # push_notification "exit"
end

def notify!(level)
  puts "TX Received! (push notif.)"
  push_notification "0 confs - 3antani - BTC TX #1 Received  - tx: 0x123456"
  # push_notification "1 confs - 3antani - BTC TX #1 Confirmed - tx: 0x123456"
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
    transaction.f :id == id
  end
end

def append_transaction(tx)
  DB[:transactions] << tx
end

def get_transactions(address:)
  UTXO.get address: address
end

def notify_on_new_transactions!(address:)
  transactions = get_transactions address: address

  p transactions

  tx = transactions.first

  # 3BLtCbn2LwVcLYCf2fU2oNRPnodgBMr5PH
  # 8e174f694402ee6fcce703ab926a56c4de152de8925cc4b77f1e821762b0a4ea

  puts "Transction:"
  p tx.inspect
  puts

  transaction = {
    idx:   0,
    id:    tx.f("tx_hash"),
    value: tx.f("value"),
    conf:  tx.f("confirmations"),
  }

  unless transaction_exists? transaction
    append_transaction transaction

    # raise DB[:transactions].inspect
    transaction_id = transaction

    notify! transaction
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

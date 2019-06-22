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

def append_transaction(tx)
  DB[:transactions].push(tx)
end

def get_transactions(address:)
  BI.transactions address: address
end

def notify_on_new_transactions!(address:)
  transactions = get_transactions address: address

  raise transaction.inspect

  append_transaction(transaction)

  raise transaction.inspect
  transaction_id = transaction


  notify! transaction if count_update
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

  sleep 60
end

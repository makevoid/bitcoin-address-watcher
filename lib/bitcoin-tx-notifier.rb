require_relative 'env'

exit

DB = {
  count: nil,
  statuses: [
    "unseen",
    "unconfirmed", # seen, unconfirmed
    "confirmed"
  ],
  transactions: [
    {
      id: 0,
      block_seen: 123123,
      block_conf: nil,
      timestamp: 123123123,
      timestamp_conf: nil,
      confirmations: 0,
    }, {
      id: 1,
      block_seen:          123123,
      block_conf:          133333,
      timestamp:        123123123,
      timestamp_conf:   133333333,
      confirmations:            2,
    }
  ]
}

at_exit do
  puts "EXIT!"
  # push_notification "exit"
end

def notify!(level)
  puts "Level up! (push notif.)"
  push_notification "Level UP! level: #{level}"
end

def count_init(new_count)
  DB[:count] = 0
end

def count_update(new_count)
  DB[:count] = new_count + 1
end

def append_transaction(tx)

end

class BlockchainInfo
  def initialize( address: )
    @address = address
  end

  def transactions
    @address
    
  end
end

def get_transactions(address)
  # BC = BitcoinCore.new
  BI = BlockchainInfo.new address: address
  BI.transactions
end

loop do
  count_init
  send_notification = true
  # send_notification = false

  get_transaction()

  append_transaction(transaction)

  transaction_id =


  notify! transaction if count_update

  sleep 60
end

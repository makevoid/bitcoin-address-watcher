# def transaction_exists?(transaction)
#   DB[:transactions].find do |tx|
#     id = tx.f :id
#     transaction.f(:id) == id
#   end
# end
#
# def append_transaction(tx)
#   DB[:transactions] << tx
# end
#
# def get_transactions(address:)
#   tx = TX.get address: address
#
#   txs = tx.f "txrefs"
#   txs.each{ |tx| tx["is_confirmed"] = true }
#   zeroconf_txs = tx["unconfirmed_txrefs"] || []
#   zeroconf_txs.each{ |tx| tx["is_confirmed"] = false }
#
#   transactions = txs + zeroconf_txs
#   tx_info = {
#     balance:          tx.f("balance"),
#     balance_zeroconf: tx.f("unconfirmed_balance"),
#   }
#
#   {
#     transactions: transactions,
#     meta: tx_info,
#   }
# end
#
#
# def build_transaction(tx:, address:, tx_info:)
#   tx_hash = tx.f "tx_hash"
#   value   = tx.f "value"
#   value_bits = (value.to_f / 100).floor
#   meta = {
#     value_bits:       value_bits,
#     tx_id_short:      tx_hash[0..6],
#     last_checked_at:  Time.now,
#     confirmed_at:     tx["confirmed"],
#     confirmed:        tx.f("is_confirmed"),
#     addr_balance:     tx_info.f(:balance),
#     addr_balance_zeroconf: tx_info.f(:balance_zeroconf),
#   }
#
#   {
#     idx:   0,
#     id:    tx_hash,
#     value: value,
#     conf:  tx.f("confirmations"),
#     addr:  address,
#     meta:  meta,
#   }
# end
#
#
# def notify_on_new_transactions!(address:)
#   transactions = get_transactions address: address
#
#   addr_details = transactions.f :meta
#   tx_info = {
#     balance:          addr_details.f(:balance),
#     balance_zeroconf: addr_details.f(:balance_zeroconf),
#   }
#   transactions = transactions.f :transactions
#
#
#   puts "Transactions:"
#   p transactions
#
#   transactions.each do |tx|
#
#     # tx = transactions.first
#
#     transaction = build_transaction tx: tx, address: address, tx_info: tx_info
#
#     puts "Transction:"
#     p transaction.inspect
#     puts
#     puts "---\n\n"
#
#     append_transaction transaction
#
#     unless old_tx = transaction_exists?(transaction)
#       notify! transaction
#     else
#       if conf_num_changed? tx: transaction, tx_old: old_tx
#         notify! transaction
#       end
#     end
#   end
#
#   puts "---\n\n"
# end



#
# def conf_num_changed?(tx:, tx_old:)
#   conf_old = tx_old.f :conf
#   conf_new = tx.f :conf
#   conf_new > conf_old && conf_new < 2
# end

# --------


# example status:
#
# "{ balance: 0,  balance_zeroconf: 10000,  tx_count: 7,  tx_zeroconf_count: 1 }"

# messages (to UI / push notification)
#   You have a new transaction!
#   "A transaction confirmed! You can spend the BTCs"
#
# messages (internal names)
#   "Balance updated "
#   "Balance updated - zeroconf"

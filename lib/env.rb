require 'net/http'
require 'json'
require 'bundler'
Bundler.require :default

# API_HOST_UTXO = "https://blockchain.info"
API_HOST = "https://api.blockcypher.com"

require_relative 'monkeypatches/hash'
require_relative 'env_secrets'
require_relative 'push/push'
require_relative 'api/get'
# require_relative 'blockchain/utxo'  # to make payments
# require_relative 'blockchain/tx'    # for accessing each tx data
require_relative 'blockchain/address' # just total balances
require_relative 'push/notifications'

TICK_TIME_DEFAULT = 19
require_relative 'main_loop_tick/tick'

client = Rushover::Client.new PUSHOVER_API_TOKEN
PUSH   = Rushover::User.new   PUSHOVER_USER_KEY, client

# Main Config

# TODO: extract config and document

def addresses_constant
  ENV["ADDRESSES"] && ENV["ADDRESSES"].split(",").map(&:strip)
end

ADDRS = addresses_constant || [
  "3N3RXbpGHn6bfvcE2nEYbvGHVPorVWgkeQ",
  # "39koh3e6NsesfUxgXvwX1AuLegr93ZQBnj",
  # "3BLtCbn2LwVcLYCf2fU2oNRPnodgBMr5PH",
]

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
# require_relative 'blockchain/utxo' # for payments
require_relative 'blockchain/tx'
require_relative 'push/notifications'
require_relative 'main_loop_tick/tick'

client = Rushover::Client.new PUSHOVER_API_TOKEN
PUSH = Rushover::User.new PUSHOVER_USER_KEY, client

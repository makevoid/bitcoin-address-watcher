require 'net/http'
require 'json'
require 'bundler'
Bundler.require :default

API_HOST = "https://blockchain.info"

require_relative 'monkeypatches/hash'
require_relative 'env_secrets'
require_relative 'push/push'
require_relative 'api/get'
require_relative 'blockchain/utxo'

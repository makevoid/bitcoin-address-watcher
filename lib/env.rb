require 'net/http'
require 'bundler'
Bundler.require :default

require_relative 'env_secrets'
require_relative 'bi/blockchain_info'
require_relative 'push/push_lib'
require_relative 'push/push'

BI = BlockchainInfo.new

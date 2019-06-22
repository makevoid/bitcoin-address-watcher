# bitcoin-tx-notifier

Bitcoin transaction notifier - on 0 and on 1 confirmations, queries bitcoind periodically via rpc, you get a notification via pushed.com (or sms via twilio (soon))


### Prereqs

- Ruby


### Config

The defult env file needs to be copied (`cp lib/env.default.rb lib/env.rb`) and configured


### Run

    rake

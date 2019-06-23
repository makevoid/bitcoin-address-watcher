# bitcoin-address-watcher

Bitcoin address watcher // transaction notifier - on 0 and on 1 confirmations, queries the blockchain via the blockcypher api, sends you a push notification when detects a transaction - supports push notification via Pushover 


### Prereqs

- Ruby or Docker


### Config

The defult env file needs to be copied (`cp lib/env_secrets.default.rb lib/env_secrets.rb`) and configured with your pushover secrets

### Run (Ruby)

    rake ADDRESS=3N3RXbpGHn6bfvcE2nEYbvGHVPorVWgkeQ


### Run on docker compose

Configure the address thay you want to watch in the [docker-compose] yml file. 

Run `docker-compose up`.

Whenever that address will receive a payment, you'll get notified!

### License

GPLV3

---

Enjoy, 

@makevoid

[docker-compose]: https://github.com/makevoid/bitcoin-tx-notifier/blob/master/docker-compose.yml#L11

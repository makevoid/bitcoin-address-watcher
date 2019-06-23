# bitcoin-tx-notifier

Bitcoin transaction notifier - on 0 and on 1 confirmations, queries blockcypher api periodically - supports notification via Pushover 


### Prereqs

- Ruby


### Config

The defult env file needs to be copied (`cp lib/env_secrets.default.rb lib/env_secrets.rb`) and configured with your pushover secrets

### Run

    rake ADDRESS=3N3RXbpGHn6bfvcE2nEYbvGHVPorVWgkeQ


### Run on docker compose

Configure the address thay you want to watch in the [docker-compose] yml file. 

Run `docker-compose up`.

Whenever that address will receive a payment, you'll get notified!

### License

GPLV3


Enjoy, 

@makevoid

[docker-compose]: https://github.com/makevoid/bitcoin-tx-notifier/blob/master/docker-compose.yml#L11

# initial state (DB)

DB = {
  count: nil,
  statuses: [
    "unseen",
    "unconfirmed", # seen, unconfirmed
    "confirmed"
  ],
  transactions: [],
  addresses: [
    {
      idx: 0,
      address: "1antani",
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
    }, {
      idx: 1,
      address: "3antani",
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
  ]

}

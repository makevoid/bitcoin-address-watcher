class Address

  extend ApiGet

  def self.get(address)
    api_url = "v1/btc/main/addrs/#{address}"
    query = { limit: 5 }
    url = url api_url: api_url, query: query
    resp = api_get url
    boom! err: resp["error"] if resp["error"]
    resp
  end

  def self.boom!(err:)
    raise "Error - probably you did too many api calls - ERROR: #{err.inspect}"
  end

end

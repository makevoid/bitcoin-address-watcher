class TX

  extend ApiGet

  def self.get(address:)
    api_url = "v1/btc/main/addrs/#{address}"
    query = { limit: 5 }
    url = url api_url: api_url, query: query
    api_get url
  end

end

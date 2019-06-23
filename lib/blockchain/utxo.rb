class UTXO

  extend ApiGet

  def self.get(address:)
    api_url = "unspent"
    query = { active: address }
    url = url api_url: api_url, query: query, host: API_HOST_UTXO
    resp = api_get url
    resp.f "unspent_outputs"
  end

end

module ApiGet

  def qs(hash:)
    hash.to_a.map { |x| "#{x[0]}=#{x[1]}" }.join "&"
  end

  def url(api_url:, query:)
    query = "?#{qs hash: query}"
    url = "#{api_url}#{query}"
    URI "#{API_HOST}/#{url}"
  end

  def api_get(url)
    resp = Net::HTTP.get_response url
    body = resp.body
    JSON.parse body
  end

  module_function :api_get

end

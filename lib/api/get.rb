module ApiGet

  def api_get(url)
    resp = Net::HTTP.get_response url
    body = resp.body
    JSON.parse body
  end

  module_function :api_get


  module Utils

    def url(api_url:, query:, host: API_HOST)
      query = "?#{qs hash: query}"
      url = "#{api_url}#{query}"
      URI "#{host}/#{url}"
    end

    def qs(hash:)
      hash.to_a.map { |x| "#{x[0]}=#{x[1]}" }.join "&"
    end

  end

  include Utils

end

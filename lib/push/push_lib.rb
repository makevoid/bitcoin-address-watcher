module PushLib

  def push!(message)
    pushed_co_request(message)
  end

  def pushed_co_request(message)
    url = URI "https://api.pushed.co/1/push"
    req = Net::HTTP::Post.new url.path
    data = {
      target_type: "app",
      content: message,
    }
    data.merge! pushed_credentials
    req.set_form_data data
    res = Net::HTTP.new url.host, url.port
    res.use_ssl = true
    res.verify_mode = OpenSSL::SSL::VERIFY_PEER
    res = res.start { |http| http.request req }
    raise "Request failed ... aborting" unless res.class == Net::HTTPOK
    true
  end

  def pushed_credentials
    {
      app_key:    PUSHED_API_KEY,
      app_secret: PUSHED_API_SEC,
    }
  end

  # usage:
  #
  #   include PushLib
  #
  #   push! "test"

end

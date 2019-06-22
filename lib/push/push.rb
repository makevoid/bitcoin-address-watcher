require_relative 'push_lib'

class Push

  extend PushLib

  def self.p(message)
    PUSH.notify message, title: "BTC"
  end

  # old - pushover impl.
  # def self.p(message)
  #   push!(message)
  # end

end

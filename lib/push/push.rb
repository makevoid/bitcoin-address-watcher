class Push

  extend PushLib

  def self.p(message)
    push!(message)
  end

end

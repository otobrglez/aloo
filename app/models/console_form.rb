class ConsoleForm
  class NotEnoughTokens < StandardError; end
  class NilReturned < StandardError; end

  include ActiveModel::Model
  attr_accessor :query

  def persisted?; false end

  def self.model_name
    ActiveModel::Name.new(self, nil, "Console")
  end

  def redis_results
    return [] if self.query.nil?
    tokens = self.query.split(" ")
    raise NotEnoughTokens.new("Needs more tokens") if tokens.size < 1
    tokens_to_send = tokens[1,tokens.size-1].map(&:to_s)

    output = if tokens_to_send.size > 0
      $redis.send(tokens.first, *tokens_to_send)
    else
      $redis.send(tokens.first)
    end

    if output.nil?
      raise NilReturned.new("Nil was returned")
    else
      output
    end
  rescue ArgumentError, NotEnoughTokens, NilReturned, Redis::CommandError => e
    "Error: #{e.class} - #{e.to_s}"
  end
end

class Board
  class RecordNotFound < StandardError; end

  include ActiveModel::Model
  FIELDS = %i{id s name public}
  attr_accessor *FIELDS
  validates :name, presence: true, length: {within: 3..30}
  validates :id, presence: true, format: {with: /\A[0-9a-f]+\z/ }
  validates :s, presence: true, format: {with: /\A[0-9a-f]+\z/ }

  def public
    "1"
  end

  def persisted?
    false
  end

  def to_param
    self.id
  end

  def to_s
    self.name
  end

  def attributes
    @attributes ||= FIELDS.map {|f| [f, self.send(f)] }
  end

  def key
    Board.key(self.id)
  end

  def save
    if valid?
      Board.redis_save self
    else
      false
    end
  end

  class << self
    def model_name
      ActiveModel::Name.new self, nil, "Board"
    end

    def key id=nil
      ["b", id].join(":")
    end

    def generate!(params={})
      Board.new(params.reverse_merge!({
        id: SecureRandom.hex[0..8],
        s: SecureRandom.hex[0..6]
      }))
    end

    def load(id)
      hash = redis_load(self.key(id))
      if hash == {}
        raise RecordNotFound.new("Board with id #{id} was not found")
      else
        Board.new(hash)
      end
    end

    def redis_load key
      $redis.hgetall key
    end

    def redis_save board
      output = $redis.hmset board.key, *board.attributes
      output == "OK"
    end

    def authenticate!(username, password)
      $redis.hget("b:#{username}", "s") == password
    end
  end
end

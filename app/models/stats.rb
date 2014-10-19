class Stats
  attr_reader :date_range

  def initialize key, match, options={}
    @key = key
    @match = match
    @options = options
  end

  def keys(rstarts_at, rends_at=nil)
    rends_at = rstarts_at if rends_at.nil?

    starts_at = if rstarts_at.is_a?(DateTime)
      rstarts_at
    elsif rstarts_at.is_a?(Date)
      rstarts_at.iso8601
    else
      DateTime.iso8601(rstarts_at)
    end

    ends_at = if rends_at.is_a?(DateTime)
      rends_at
    elsif rends_at.is_a?(Date)
      rends_at.iso8601
    else
      DateTime.iso8601(rends_at)
    end

    (@date_range = (starts_at..ends_at)).map do |date|
      k = KpiKey.new(@key, date)
      k.keys
    end.flatten.uniq
  end

  def results
    pkeys = keys(@options[:starts_at], @options[:ends_at])
    final_keys = pkeys.grep @match
    result = $redis.mget final_keys

    final_keys.zip(result).map do |rkey, value|
      [rkey, value]
    end
  end
end

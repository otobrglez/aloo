class Stats
  def initialize project, key, match, options={}
    @project = project
    @key = key
    @match = match
    @options = options
  end

  def keys(rstarts_at, rends_at=nil)
    rends_at = rstarts_at if rends_at.nil?

    starts_at = if rstarts_at.is_a?(DateTime)
      rstarts_at
    else
      DateTime.iso8601(rstarts_at)
    end

    ends_at = if rends_at.is_a?(DateTime)
      rends_at
    else
      DateTime.iso8601(rends_at)
    end

    (starts_at..ends_at).map do |date|
      k = KPIKey.new(@project, date, @key)
      k.keys
    end.flatten.uniq
  end

  def results
    pkeys = keys(@options[:starts_at], @options[:ends_at])
    final_keys = pkeys.grep @match
    result = $redis.mget final_keys

    final_keys.zip(result).map do |rkey, value|
      k_split = rkey.split(":")
      {
        key: rkey,
        project: k_split[0],
        name: k_split[1],
        value: value
      }
    end
  end
end

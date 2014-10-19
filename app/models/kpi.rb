class Kpi < Struct.new(:key, :date, :value)
  def keys
    @keys ||= KpiKey.new(key, date).keys
  end

  def create!
    keys.each_with_index do |key, index|
      $redis.pipelined do
        $redis.set key, value
      end
    end
  end
end

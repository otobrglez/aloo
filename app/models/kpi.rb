class KPI < Struct.new(:project, :date, :key, :value)
  def keys
    @keys ||= KPIKey.new(project, date, key).keys
  end

  def create!
    keys.each_with_index do |key, index|
      $redis.pipelined do
        $redis.set key, value
      end
    end
  end
end

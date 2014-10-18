KPI = Struct.new(:project, :date, :key, :value) do

  def keys
    @keys ||= KPIKey.new(project, date, key).keys
  end
end

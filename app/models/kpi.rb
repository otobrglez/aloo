KPI = Struct.new(:project, :metric, :date, :value) do

  attr_reader :sdate
  def sdate
    @sdate ||= if date.is_a?(DateTime)
      date
    else
      DateTime.iso8601(date)
    end
  end

  def keys
    []
  end
end

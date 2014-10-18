KPIKey = Struct.new(:project, :rdate, :key) do

  def date
    @date ||= if rdate.is_a?(DateTime)
      rdate
    else
      DateTime.iso8601(rdate)
    end
  end

  def year; @year ||= date.strftime('%y')                       end
  def quarter; @quarter ||= ((date.month - 1) / 3) + 1          end
  def month_in_year; @month_in_year ||= date.month              end
  def week_in_year; @week_in_year ||= date.strftime('%W').to_i  end
  def day_in_week; @day_in_week ||= date.wday                   end
  def day_in_year; @day_in_year ||= date.yday                   end
  def hour_in_day; @hour_in_day ||= date.hour                   end

  def keys
    @keys ||= [
      # Yearly
      [key, year],

      # Quarterly
      [key, year, 'q', quarter],

      # Weekly
      [key, year, 'w', day_in_week]
    ].map {|k| k.join(":") }
  end
end

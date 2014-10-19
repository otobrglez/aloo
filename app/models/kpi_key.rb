class KpiKey < Struct.new(:rkey, :rdate)
  class InvalidKeyFormat < StandardError; end
  class InvalidProjectFormat < StandardError; end

  VALID_KEY_FORMAT =  /^[a-z0-9\:]{3,50}$/

  def date
    @date ||= if rdate.is_a?(DateTime)
      rdate
    elsif rdate.is_a?(Date)
      rdate.iso8601
    else
      # raise StandardError.new(rdate.class.to_s+" #{rdate}")
      DateTime.iso8601(rdate)
    end
  end

  def valid_key
    raise InvalidKeyFormat.new(rkey) if rkey !~ VALID_KEY_FORMAT

    rkey
  end

  def year; @year ||= date.strftime('%y')                       end
  def quarter; @quarter ||= ((date.month - 1) / 3) + 1          end
  def month_in_year; @month_in_year ||= date.month              end
  def week_in_year; @week_in_year ||= date.strftime('%W').to_i  end
  def day_in_week; @day_in_week ||= date.wday                   end
  def day_in_year; @day_in_year ||= date.yday                   end
  def hour_in_day; @hour_in_day ||= date.hour                   end

  def key
    @key ||= valid_key
  end

  def keys
    @keys ||= [
      # Yearly
      [key, year],

      # Quarterly
      [key, year, 'q', quarter],

      # Monthly
      [key, year, 'm', month_in_year],

      # Weekly
      [key, year, 'w0', week_in_year],

      # Daily
      [key, year, 'd', day_in_year]

      # Hourly
      # [key, year, 'h', day_in_year]

    ].map {|k| k.join(":") }
  end
end

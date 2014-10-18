class KPIKey < Struct.new(:rproject, :rdate, :rkey)
  class InvalidKeyFormat < StandardError; end
  class InvalidProjectFormat < StandardError; end

  VALID_PROJECT_FORMAT = /^[a-zA-Z]{3,7}$/
  VALID_KEY_FORMAT =  /^[a-zA-Z_]{3,50}$/

  def date
    @date ||= if rdate.is_a?(DateTime)
      rdate
    else
      DateTime.iso8601(rdate)
    end
  end

  def valid_key
    raise InvalidKeyFormat.new(rkey) if rkey !~ VALID_KEY_FORMAT
    rkey
  end

  def valid_project
    raise InvalidProjectFormat.new(rproject) if rproject !~ VALID_PROJECT_FORMAT
    rproject
  end

  def year; @year ||= date.strftime('%y')                       end
  def quarter; @quarter ||= ((date.month - 1) / 3) + 1          end
  def month_in_year; @month_in_year ||= date.month              end
  def week_in_year; @week_in_year ||= date.strftime('%W').to_i  end
  def day_in_week; @day_in_week ||= date.wday                   end
  def day_in_year; @day_in_year ||= date.yday                   end
  def hour_in_day; @hour_in_day ||= date.hour                   end

  def key
    @key ||= [valid_project, valid_key].join(":")
  end

  def keys
    @keys ||= [
      # Yearly
      [key, year],

      # Quarterly
      [key, year, 'q', quarter],

      # Weekly
      [key, year, 'w0', week_in_year],

      # Daily
      [key, year, 'd', day_in_year]

      # Hourly
      # [key, year, 'h', day_in_year]

    ].map {|k| k.join(":") }
  end
end

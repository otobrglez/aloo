require 'rails_helper'

RSpec.describe Stats do
  context "week_vs_prevweek" do
    let(:list) { [
      KPI.new("test", "2013-01-01", "sales", 100),
      KPI.new("test", "2013-01-02", "sales", 200),
      KPI.new("test", "2014-01-01", "sales", 100),
      KPI.new("test", "2014-01-02", "sales", 200),
      KPI.new("test", "2014-01-03", "sales", 300),
      KPI.new("test", "2014-01-04", "sales", 100),
      KPI.new("test", "2014-01-05", "sales", 200),
      KPI.new("test", "2014-01-06", "sales", 40),
      KPI.new("test", "2014-01-07", "sales", 100),
      KPI.new("test", "2014-01-08", "sales", 200),
      KPI.new("test", "2014-01-09", "sales", 300),
      KPI.new("test", "2014-01-10", "sales", 300),
      KPI.new("test", "2014-01-13", "sales", 200),
      KPI.new("test", "2014-01-14", "sales", 100),
      KPI.new("test", "2014-01-15", "sales", 200),
      KPI.new("test", "2014-01-16", "sales", 40),
      KPI.new("test", "2014-01-17", "sales", 0),
      KPI.new("test", "2014-01-20", "sales", 80),
      KPI.new("test", "2014-01-22", "sales", 400),
      KPI.new("test", "2014-01-23", "sales", 600),
      KPI.new("test", (Date.today-9.weeks).iso8601,  "sales", 800),
      KPI.new("test", (Date.today-8.weeks).iso8601,  "sales", 870),
      KPI.new("test", (Date.today-7.weeks).iso8601,  "sales", 870),
      KPI.new("test", (Date.today-3.weeks).iso8601,  "sales", 1000),
      KPI.new("test", (Date.today-2.weeks).iso8601,  "sales", 1200),
      KPI.new("test", (Date.today-1.weeks).iso8601,   "sales", 1230),
      KPI.new("test", (Date.today-9.days).iso8601,  "sales", 800),
      KPI.new("test", (Date.today-8.days).iso8601,  "sales", 870),
      KPI.new("test", (Date.today-7.days).iso8601,  "sales", 870),
      KPI.new("test", (Date.today-3.days).iso8601,  "sales", 1400),
      KPI.new("test", (Date.today-2.days).iso8601,  "sales", 1500),
      KPI.new("test", (Date.today-1.day).iso8601,   "sales", 1630),
      KPI.new("test", (Date.today).iso8601,         "sales", 1700),
    ] }

    before { list.map(&:create!) }

    it {
      # Sales for last week
      puts Stats.new('test', 'sales', /\:d\:/, {
        starts_at: (Date.today.beginning_of_week).iso8601,
        ends_at: (Date.today.end_of_week).iso8601,
      }).results.map {|r| r[:value] || 0 }
    }

  end
end

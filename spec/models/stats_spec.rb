require 'rails_helper'

RSpec.describe Stats do
  context "week_vs_prevweek" do
    let(:list) { [
      Kpi.new("test", "2013-01-01", 100),
      Kpi.new("test", "2013-01-02", 200),
      Kpi.new("test", "2014-01-01", 100),
      Kpi.new("test", "2014-01-02", 200),
      Kpi.new("test", "2014-01-03", 300),
      Kpi.new("test", "2014-01-04", 100),
      Kpi.new("test", "2014-01-05", 200),
      Kpi.new("test", "2014-01-06", 40),
      Kpi.new("test", "2014-01-07", 100),
      Kpi.new("test", "2014-01-08", 200),
      Kpi.new("test", "2014-01-09", 300),
      Kpi.new("test", "2014-01-10", 300),
      Kpi.new("test", "2014-01-13", 200),
      Kpi.new("test", "2014-01-14", 100),
      Kpi.new("test", "2014-01-15", 200),
      Kpi.new("test", "2014-01-16", 40),
      Kpi.new("test", "2014-01-17", 0),
      Kpi.new("test", "2014-01-20", 80),
      Kpi.new("test", "2014-01-22", 400),
      Kpi.new("test", "2014-01-23", 600),
      Kpi.new("test", (Date.today-9.weeks).iso8601, 800),
      Kpi.new("test", (Date.today-8.weeks).iso8601, 870),
      Kpi.new("test", (Date.today-7.weeks).iso8601, 870),
      Kpi.new("test", (Date.today-3.weeks).iso8601, 1000),
      Kpi.new("test", (Date.today-2.weeks).iso8601, 1200),
      Kpi.new("test", (Date.today-1.weeks).iso8601, 1230),
      Kpi.new("test", (Date.today-9.days).iso8601,  800),
      Kpi.new("test", (Date.today-8.days).iso8601,  870),
      Kpi.new("test", (Date.today-7.days).iso8601,  870),
      Kpi.new("test", (Date.today-3.days).iso8601,  1400),
      Kpi.new("test", (Date.today-2.days).iso8601,  1500),
      Kpi.new("test", (Date.today-1.day).iso8601,   1630),
      Kpi.new("test", (Date.today).iso8601,         1700),
    ] }

    before { list.map(&:create!) }

    it {
      results = Stats.new('test', /\:d\:/, {
        starts_at: (Date.today.beginning_of_week).iso8601,
        ends_at: (Date.today.end_of_week).iso8601,
      }).results.map {|r| r }

      expect(results.compact.size).not_to eq 0
    }

  end
end

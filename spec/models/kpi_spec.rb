require 'rails_helper'

RSpec.describe KPI do

  context "basic example" do
    subject { KPI.new("test", "visits", "2014-01-01T18:00:00", 100) }
    it { expect(subject.keys).to be_kind_of Array }
    it { expect(subject.sdate).to be_kind_of DateTime }
  end

end

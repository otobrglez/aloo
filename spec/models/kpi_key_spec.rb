require 'rails_helper'

RSpec.describe KPIKey do
  subject { KPIKey.new('test', '2014-10-18', 'visit') }
  it { expect(subject.date).to be_kind_of DateTime }
  it { expect(subject.key).to eq "test:visit" }
  it { expect(subject.year).to eq "14" }
  it { expect(subject.quarter).to eq 4 }
  it { expect(subject.month_in_year).to eq 10 }
  it { expect(subject.day_in_year).to eq 291 }
  it { expect(subject.day_in_week).to eq 6 }
  it { expect(subject.hour_in_day).to eq 0 }

  context "validation" do
    it {
      expect {
        KPIKey.new('test','2014-10-10',' d d a d dddd').key
      }.to raise_error KPIKey::InvalidKeyFormat
    }

    it {
      expect {
        KPIKey.new('  ','2014-10-10','i_was_here_u_know').key
      }.to raise_error KPIKey::InvalidProjectFormat
    }
  end
end

require 'rails_helper'

RSpec.describe KPI do
  before(:each) { $redis.flushdb }

  context "basic example" do
    before { allow($redis).to receive(:set).and_return("OK") }
    subject { KPI.new("test", "2014-01-01T18:00:00", "visits", 100) }
    it { expect(subject.keys).to be_kind_of Array }
    it { expect { subject.create! }.not_to raise_error }
  end

  context "bulk create" do
    let(:list) { [
      KPI.new("test", "2014-01-01", "sales", 100),
      KPI.new("test", "2014-01-02", "sales", 200),
    ] }

    before { list.map(&:create!) }

    context "creates stats" do
      it { expect($redis.keys).not_to be_empty }
    end
  end
end


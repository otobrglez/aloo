require 'rails_helper'

RSpec.describe Board do
  context "validation" do
    subject { Board.new }
    it { expect(subject).to be_invalid }
  end

  context "generate new board" do
    subject { Board.generate! }
    it { expect(subject.id).to match /^[0-9a-f]+/ }
  end

  context "to_param" do
    subject { Board.generate! }
    it { expect(subject.to_param).to match /[0-9a-f]+/ }
  end

  context "save" do
    it { expect(
      Board.generate!(name: 'my visits').save
    ).to eq true }
  end

  context "load" do
    it {
      expect {
        Board.load("123")
      }.to raise_error(Board::RecordNotFound)
    }
  end

  context "authenticate" do
    it { expect(Board.authenticate!("d","b")).to eq false }

    context "board exists" do
      let(:board) do
        board = Board.generate!(name: 'my visits')
        board.save
        board
      end

      it {
        expect(
          Board.authenticate!(board.id, board.s)
        ).to eq true
      }
    end
  end
end

require 'rails_helper'

RSpec.describe Api::KpisController do
  let!(:board) do
    board = Board.generate!(name: "Visits")
    board.save
    board
  end

  let(:kpi){['2014-10-18', 1000]}

  context "can't create if no secret" do
    before { post :create, kpi: kpi }
    it { expect(response).not_to be_success }
  end

  context "create one" do
    before { http_authenticate(board.id, board.s) }
    before { post :create, kpi: kpi }
    it { expect(response).to be_success }
  end

  context "create bulk" do
    before { http_authenticate(board.id, board.s) }
    before do
      kpis = [kpi, kpi, kpi]
      post :create, kpis: kpis
    end
    it { expect(response).to be_success }
  end

  def http_authenticate(username, password)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(username, password)
  end
end

require 'rails_helper'

RSpec.describe BoardsController do
  context "hiting boards" do
    before { get :index }
    it { expect(response).to redirect_to root_url }
  end

  context "creating new board" do
    context "invalid" do
      before { post :create, board: {}}
      it { expect(response).to render_template 'home/index' }
    end

    context "valid" do
      before { post :create, board: { name: 'visits'} }
      it { expect(response).to redirect_to("/boards/#{assigns(:board).id}?show_help=1") }
    end
  end
end

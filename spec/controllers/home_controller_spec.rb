require 'rails_helper'

RSpec.describe HomeController do
  render_views
  describe "GET /" do
    before { get :index }
    it { expect(response).to be_success }
  end
end

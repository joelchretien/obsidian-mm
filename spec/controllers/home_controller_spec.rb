require "rails_helper"

RSpec.describe HomeController do
  describe "GET #index" do
    it "returns status ok" do
      log_in(instance_double(User))
      get :index

      expect(response.status).to be(200)
    end
  end
end

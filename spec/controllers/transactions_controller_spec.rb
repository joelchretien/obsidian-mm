require 'rails_helper'

describe TransactionsController do
  describe "#index" do
    it { requires_signed_in_user_to { get :index } }

    it "Displays the transactions" do
      user = FactoryBot.create(:current_user) 
      # TODO: How do I test pagination on user.transactions instead of 
      # user.transactions.expect(:paginate).with(page: "2").returns([].paginate)
      sign_in user
      get :index
      assert_response :success
      assert assigns(:transactions)
    end
  end

end

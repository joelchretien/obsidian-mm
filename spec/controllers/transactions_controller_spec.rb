require 'rails_helper'

describe TransactionsController do
  describe "#index" do
    it { requires_signed_in_user_to { get :index } }

    it "Displays the transactions in a paginaed format by descending transaction date" do
      #JC: Simplify or turn into a feature spec?
      user = FactoryBot.create(:current_user)
      dbl_user = double("user")
      allow(controller).to receive(:current_user).and_return(dbl_user)
      transactions = double("transactions")
      allow(dbl_user).to receive(:transactions).and_return(transactions)
      paginated_transactions = double("paginated_transactions")
      allow(transactions).to receive(:paginate).and_return(paginated_transactions)
      ordered_transactions = double("ordered_transactions")
      allow(paginated_transactions).to receive(:order).with("transaction_date DESC").and_return(ordered_transactions)

      sign_in user
      get :index

      assert_response :success
      assert assigns(:transactions)
      expect(dbl_user).to have_received(:transactions)
      expect(transactions).to have_received(:paginate)
      expect(paginated_transactions).to have_received(:order)
    end
  end

end

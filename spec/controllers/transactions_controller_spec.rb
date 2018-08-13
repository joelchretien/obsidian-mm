require 'rails_helper'

describe TransactionsController do
  describe "#index" do
    it { requires_signed_in_user_to { get :index, params: { account_id: 1} } }
  end
end

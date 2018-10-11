describe AccountsController do
  describe "#index" do
    it { requires_signed_in_user_to { get :index } }

    it "displays the accounts" do
      # TODO: Test other things here
      user = FactoryBot.create(:user)

      sign_in user
      get :index

      assert_response :success
      assert assigns(:accounts)
    end
  end
end

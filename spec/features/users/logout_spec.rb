require 'spec_helper'

feature 'Logout' do
  describe 'Logging out' do
    it 'allows the user to logout' do
      email = "example@example.com"
      password = "123456"
      user = FactoryBot.create(:user, email: email, password: password)
      visit root_path
      fill_in "user_email", with: email
      fill_in "user_password", with: password
      click_button "Log in"

      click_link "Log out"

      expect(page).to have_content("Log in")
    end
  end
end

require 'spec_helper'

feature 'Login' do
  describe 'Signing up' do
    it 'allows the user to sign up' do
      visit root_path

      user = "example@example.com"
      password = "123456"
      click_link "Sign up"
      fill_in "user_email", :with => user
      fill_in "user_password", :with => password
      fill_in "user_password_confirmation", :with => password
      click_button "Sign up"
      open_email(user)
      visit_in_email("Confirm my account")

      message = "Your email address has been successfully confirmed"
      expect(page).to have_content(message)
    end
  end
end

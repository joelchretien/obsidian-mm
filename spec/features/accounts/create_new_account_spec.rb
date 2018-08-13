feature "create a new account" do
  scenario "when the name doesn't already exist", js: true do
    user = create :user
    login_as user
    visit accounts_path
    account_name = 'New Account 1'

    find('a', text: /New Account?/i).click
    fill_in('account_name', with: account_name)
    click_button('Save')

    expect(page).to have_content(account_name)
  end
end

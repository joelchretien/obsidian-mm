feature "Edit an account" do
  scenario "with valid parameters", js: true do
    user = create :user
    login_as user
    account = create :account, user: user
    visit accounts_path
    account_name = "EditedAccountName"

    tr = find_by_data_id(account.id)
    tr.find(".edit-button").click
    fill_in("account_name", with: account_name)
    click_button("Save")

    expect(tr).to have_content(account_name)
  end
end

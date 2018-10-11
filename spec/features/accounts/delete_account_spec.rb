require "rails_helper"

feature "Delete an account" do
  scenario "with valid parameters" do
    account_name = "AccountToBeDeleted"
    user = create :user
    login_as user
    account = create :account, user: user
    account.name = account_name
    visit accounts_path

    tr = find_by_data_id(account.id)
    tr.find(".delete-button").click

    expect(tr).not_to have_content(account_name)
  end
end

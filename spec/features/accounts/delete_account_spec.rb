feature "Delete an account" do
  scenario "with valid parameters" do
    account_name = "AccountToBeDeleted"
    user = create :user
    login_as user
    account = create :account, user: user
    account.name = account_name
    visit accounts_path

    tr = find_by_data_id(account.id)
    tr.find('.delete-button').click

    expect(tr).not_to have_content(account_name)
  end

  #TODO: Remove this and only have it in the support folder
  def find_by_data_id(data_id)
    find_string = "[data-id=\"#{data_id.to_s}\"]"
    tr = find(find_string)
    tr
  end
end

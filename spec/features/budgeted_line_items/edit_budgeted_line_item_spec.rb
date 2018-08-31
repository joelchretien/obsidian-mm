feature "Edit an account" do
  scenario "with valid parameters", js: true do
    user = create :user
    login_as user
    account = create :account, user: user
    budgeted_line_item = create :budgeted_line_item, account: account
    visit account_budgeted_line_items_path(account)
    budgeted_line_item_name = 'BudgetedLineItemName'

    tr = find_by_data_id(budgeted_line_item.id)
    tr.find('.edit-button').click
    fill_in('budgeted_line_item_name', with: budgeted_line_item_name)
    click_button('Save')

    expect(tr).to have_content(budgeted_line_item_name)
  end
end

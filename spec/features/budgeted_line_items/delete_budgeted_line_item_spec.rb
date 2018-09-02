require 'rails_helper'

feature "Delete a budgeted line item" do
  scenario "with valid parameters" do
    budgeted_line_item_name = "budgeted-line-item-name"
    user = create :user
    login_as user
    account = create :account, user: user
    budgeted_line_item = create :budgeted_line_item, account: account, description: budgeted_line_item_name
    visit account_budgeted_line_items_path(account)

    tr = find_by_data_id(budgeted_line_item.id)
    tr.find('.delete-button').click

    expect(page).not_to have_content(budgeted_line_item_name)
  end
end

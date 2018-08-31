feature "create a new budgeted line item" do
  scenario "when the name doesn't already exist", js: true do
    user = create :user
    login_as user
    account = create :account, user: user
    visit account_budgeted_line_items_path(account)
    budgeted_line_item_name = 'item-name'

    find('a', text: /New Item?/i).click
    fill_in 'budgeted_line_item_description', with: budgeted_line_item_name
    fill_in 'budgeted_line_item_amount', with: 10
    select 'Monthly', from: "budgeted_line_item_recurrence"

    fill_in 'budgeted_line_item_recurrence_multiplier', with: '1'
    #TODO: Add in a date
    # fill_in 'budgeted_line_item_start_date', with: Date.today.to_s
    click_button('Save')

    expect(page).to have_content(budgeted_line_item_name)
  end
end

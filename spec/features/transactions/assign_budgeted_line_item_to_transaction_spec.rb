feature 'assign budgeted line item to transaction' do
  scenario 'when transaction is unassigned', js: true do
    transaction_name = "targetTransaction"
    target_budgeted_line_item = "targetBudget"
    current_user = create_current_user_with_transactions_and_budgets()
    target_transaction = current_user.accounts[0].transactions[0]
    target_transaction.description = transaction_name
    account = current_user.accounts[0]
    budgeted_line_item = account.budgeted_line_items[0]
    budgeted_line_item.description = target_budgeted_line_item
    budgeted_line_item.save!
    login_as current_user, scope: :user
    visit account_transactions_path(account)

    tr = find_by_data_id(target_transaction.id)
    expect(tr).not_to have_content(target_budgeted_line_item)
    tr.find('.assign-budget').click
    select target_budgeted_line_item, from: "transaction_budgeted_line_item_id"
    find('.edit_transaction').find('input[type="submit"]').click

    expect(tr).to have_content(target_budgeted_line_item)
  end

  def create_current_user_with_transactions_and_budgets()
    user = create :user
    account = create :account, user: user
    create_list(:transaction, 3, account: account)
    create_list(:budgeted_line_item, 3, account: account) 
    user
  end
  
  #TODO: Remove this and only have it in the support folder
  def find_by_data_id(data_id)
    find_string = "[data-id=\"#{data_id.to_s}\"]"
    tr = find(find_string)
    tr
  end
end

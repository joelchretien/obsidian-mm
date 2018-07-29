feature 'assign budgeted line item to transaction' do
  scenario 'when transaction is unassigned' do
    transaction_name = "targetTransaction"
    target_budgeted_line_item = "targetBudget"
    current_user = create_current_user_with_transactions_and_budgets()
    target_transaction = current_user.transactions[0]
    target_transaction.description = transaction_name
    current_user.budgeted_line_items[0].description = target_budgeted_line_item
    login_as current_user, scope: :user
    visit transactions_path

    tr = find_row_by_transaction_id(target_transaction.id)
    expect(tr).not_to have_content(target_budgeted_line_item)

    tr.find('.assign-budget').click
    click_link target_budgeted_line_item

    # Do I need this?
    # tr = find_row_by_transaction_id(target_transaction.id)
    expect(tr).to have_content(target_budgeted_line_item)
  end

  def create_current_user_with_transactions_and_budgets()
    current_user = FactoryBot.create :current_user
    FactoryBot.create_list(:current_user_transactions, 3, user: current_user)
    FactoryBot.create_list(:current_user_bugeted_line_items, 3, user: current_user)
    current_user
  end
  
  def find_row_by_transaction_id(transaction_id)
    find_string = 'tr[data-id="' + transaction_id.to_s+'"]'
    tr = find(find_string)
    tr
  end
end

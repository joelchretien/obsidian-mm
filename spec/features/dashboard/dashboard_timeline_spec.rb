require "rails_helper"

feature "timeline on dashboard page" do
  scenario "shows upcoming transactions" do
    account = create_transaction_and_budget() do |transaction, budget|
      transaction.transaction_date = Date.today - 1.months
      budget.recurrence = :monthly
      budget.recurrence_multiplier = 1
    end

    visit_dashboard_page(account)

    budgeted_line_item = account.budgeted_line_items.first
    matches = find_timeline_with(
      description: budgeted_line_item.description,
      transaction_date: Date.today
    )
    expect(matches.count).to eq(1)
  end

  def visit_dashboard_page(account)
    login_as account.user, scope: :user
    visit account_dashboard_index_path(account)
  end

  def find_timeline_with(description: nil, transaction_date: nil)
    timeline_items = all(".timeline-item")
    if !description.nil?
      results = []
      timeline_items.each do |item|
        #TODO:Remove rescue here
        begin
          if !item.first(".description", text: description).nil?
            results << item
          end
        rescue
        end
      end
      timeline_items = results
    end
    if !transaction_date.nil?
      results = []
      timeline_items.each do |item|
        #TODO:Remove rescue here
        begin
          if !item.first(".transaction_date", text: transaction_date.strftime("%b %-d, %y")).nil?
            results << item
          end
        rescue
        end
      end
      timeline_items = results
    end
    timeline_items
  end
end

require "rails_helper"

feature "timeline on dashboard page" do
  scenario "show upcoming transactions" do
    visit_dashboard_page
  end

  def visit_dashboard_page
    user = create :user
    account = create :account, user: user
    login_as user, scope: :user
    visit account_transactions_path(account)
  end
end

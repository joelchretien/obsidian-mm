describe TransactionImport::BudgetAssigner do
  context "when a transaction description matches the budgeted line item" do
    context "and the transaction is between the start and end date of the budgeted line item" do
      it "assigns the transaction" do
        service = create_service(
          transaction_date: Date.today,
          description_matches: true
        )
        service.call

        transaction = service.transactions.first
        expect(transaction.budgeted_line_item).to eq(service.budgeted_line_items.first)
      end
    end

    context "and the transaction is before the start date of the budgeted line item" do
      it "does not assign the transactions" do
        service = create_service(
          transaction_date: Date.today - 2.days,
          description_matches: true
        )
        service.call

        expect(service.transactions.first.budgeted_line_item).to be_nil
      end
    end

    context " and the transaction is after the end date of the budgeted line item" do
      it "does not assign the transactions" do
        service = create_service(
          transaction_date: Date.today + 2.days,
          description_matches: true
        )
        service.call

        expect(service.transactions.first.budgeted_line_item).to be_nil
      end
    end
  end

  context "when a transaction description does not match the budgeted line item" do
    context "and the transaction is between the start and end date of the budgeted line item" do
      it "does not assign the transaction" do
        service = create_service(
          transaction_date: Date.today,
          description_matches: false
        )
        service.call

        expect(service.transactions.first.budgeted_line_item).to be_nil
      end
    end
  end

  def create_service(transaction_date:, description_matches:)
    account = create :account
    transaction = create :transaction, account: account, transaction_date: transaction_date
    transaction_description = description_matches ? transaction.description : "Something else"
    budgeted_line_item = create :budgeted_line_item,
      account: account,
      start_date: Date.yesterday,
      end_date: Date.today + 1.day,
      transaction_descriptions: transaction_description

    service = TransactionImport::BudgetAssigner.new(
      transactions: [transaction],
      budgeted_line_items: [budgeted_line_item],
      save: false
    )
    service
  end
end

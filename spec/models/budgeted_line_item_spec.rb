describe BudgetedLineItem do
  it { is_expected.to belong_to(:user) }

  describe "#recurence" do
    it { is_expected.to define_enum_for(:recurrence).with([:no_recurrence, :weekly, :monthly, :yearly] ) }
  end

  describe ".per_page" do
    #JC: Research how to test this
  end

  describe "#recurrence_text" do
    it "returns the valid recurrence_text when there is no recurrence" do
      budgeted_line_item = FactoryBot.create(:budgeted_line_item)
      budgeted_line_item.no_recurrence!
      expect(budgeted_line_item.recurrence_text).to eq("one time")
    end

    context "when it is a weekly recurrence" do
      it "returns the valid recurrence_text (singular)" do
        budgeted_line_item = FactoryBot.create(:budgeted_line_item, recurrence_multiplier: 1)
        budgeted_line_item.weekly!
        expect(budgeted_line_item.recurrence_text).to eq("Every 1 week")
      end

      it "returns the valid recurrence_text (plural)" do
        budgeted_line_item = FactoryBot.create(:budgeted_line_item, recurrence_multiplier: 2)
        budgeted_line_item.weekly!
        expect(budgeted_line_item.recurrence_text).to eq("Every 2 weeks")
      end
    end

    context "when it is a monthly recurrence" do
      it "returns the valid recurrence_text (singular)" do
        budgeted_line_item = FactoryBot.create(:budgeted_line_item, recurrence_multiplier: 1)
        budgeted_line_item.monthly!
        expect(budgeted_line_item.recurrence_text).to eq("Every 1 month")
      end

      it "returns the valid recurrence_text (plural)" do
        budgeted_line_item = FactoryBot.create(:budgeted_line_item, recurrence_multiplier: 2)
        budgeted_line_item.monthly!
        expect(budgeted_line_item.recurrence_text).to eq("Every 2 months")
      end
    end

    context "when it is a yearly recurrence" do
      it "returns the valid recurrence_text (singular)" do
        budgeted_line_item = FactoryBot.create(:budgeted_line_item, recurrence_multiplier: 1)
        budgeted_line_item.yearly!
        expect(budgeted_line_item.recurrence_text).to eq("Every 1 year")
      end

      it "returns the valid recurrence_text (plural)" do
        budgeted_line_item = FactoryBot.create(:budgeted_line_item, recurrence_multiplier: 2)
        budgeted_line_item.yearly!
        expect(budgeted_line_item.recurrence_text).to eq("Every 2 years")
      end
    end
  end
end

describe Account do
  context "associations" do
    it { is_expected.to have_many(:transactions).dependent(:destroy) }
    it { is_expected.to have_one(:user_entered_balance).dependent(:destroy) }
    it { is_expected.to have_many(:budgeted_line_items).dependent(:destroy) }
    it { is_expected.to have_many(:imported_files).dependent(:destroy) }
  end

  context "#name" do
    it { is_expected.to validate_presence_of(:name) }
  end

  context "#import_configuration_options" do
    it { is_expected.to validate_presence_of(:import_configuration_options) }
  end
end

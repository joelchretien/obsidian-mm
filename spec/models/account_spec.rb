
describe Account do
  context "associations" do
    it { should have_many(:transactions).dependent(:destroy)}
    it { should have_many(:budgeted_line_items).dependent(:destroy)}
    it { should have_many(:imported_files).dependent(:destroy)}
  end

  context "#name" do
    it { is_expected.to validate_presence_of(:name)}
  end

  context '#import_configuration_options' do
    it { is_expected.to validate_presence_of(:import_configuration_options) }
  end
end

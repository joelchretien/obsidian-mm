describe ImportFileRequest do
  context "#account" do
    it "validates presence of :account" do
      imported_file = create(:imported_file)
      import_file_request = build(:import_file_request, account: imported_file.account)
      import_file_request.account = nil
      expect(import_file_request).not_to be_valid
    end
  end

  context "#source_file" do
    it "validates presence of :source_file" do
      imported_file = create(:imported_file)
      import_file_request = build(:import_file_request, account: imported_file.account)
      import_file_request.source_file = nil
      expect(import_file_request).not_to be_valid
    end
  end

  context "#last_balance" do
    it "Doesn't validate presence of last balance if imported file exists" do
      imported_file = create(:imported_file)
      import_file_request = build(:import_file_request, account: imported_file.account)
      import_file_request.last_balance = nil
      expect(import_file_request).to be_valid
    end

    it "Validates presence of last balance if imported file doesn't exist" do
      import_file_request = build(:import_file_request, last_balance: nil)
      expect(import_file_request).not_to be_valid
    end
  end
end

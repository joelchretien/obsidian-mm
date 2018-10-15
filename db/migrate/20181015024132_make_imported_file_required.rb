class MakeImportedFileRequired < ActiveRecord::Migration[5.2]
  def change
    change_column_null :transactions, :imported_file_id, false
  end
end

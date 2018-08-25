class CreateFilesToImport < ActiveRecord::Migration[5.2]
  def change
    create_table :imported_files do |t|
      t.references :account, foreign_key: true
      t.text :filename

      t.timestamps
    end

    change_table :transactions do |t|
      t.references :imported_file, foreign_key: true
    end
  end
end

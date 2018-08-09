class CreateImportedFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :imported_files do |t|
      t.references :user, foreign_key: true
      t.text :filename

      t.timestamps
    end
  end
end

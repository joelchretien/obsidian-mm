class AddImportConfigurationOption < ActiveRecord::Migration[5.2]
  def change
    change_table :accounts do |t|
      t.json :import_configuration_options
    end
  end
end

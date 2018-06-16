class AddIndexConfirmationTokenToDevise < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :confirmation_token, unique: true
    User.all.update_all confirmed_at: DateTime.now
  end
end

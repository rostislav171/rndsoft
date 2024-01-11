class AddLastUsernameChangeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :last_username_change, :datetime
  end
end

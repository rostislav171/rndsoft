class AddEditsCountToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :edits_count, :integer
  end
end

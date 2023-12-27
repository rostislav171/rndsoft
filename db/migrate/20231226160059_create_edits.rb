class CreateEdits < ActiveRecord::Migration[7.1]
  def change
    create_table :edits do |t|
      t.belongs_to :post, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end

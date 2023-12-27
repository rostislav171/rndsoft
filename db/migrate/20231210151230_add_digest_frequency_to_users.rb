class AddDigestFrequencyToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :digest_frequency, :string
  end
end

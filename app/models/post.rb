class Post < ApplicationRecord
  belongs_to :user
  has_many :edits, dependent: :destroy
  attribute :edits_count, :integer, default: 0
end

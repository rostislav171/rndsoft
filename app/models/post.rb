# app/models/post.rb
class Post < ApplicationRecord
  belongs_to :user
  has_many :edits, dependent: :destroy
  attribute :edits_count, :integer, default: 0

  validates :title, presence: true
  validates :content, presence: true

  after_create :update_edits_count

  private

  def update_edits_count
    update(edits_count: edits.count)
  end
end

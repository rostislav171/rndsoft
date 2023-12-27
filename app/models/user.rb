class User < ApplicationRecord

  has_many :posts

  has_one :editor, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum digest_frequency: { ежедневно: 'daily', еженедельно: 'weekly', отказ: 'none' }

  validates :username, presence: true, uniqueness: true

  attribute :posts_count, :integer, default: 0
  
  def editor?
    self.editor.present?
  end
end

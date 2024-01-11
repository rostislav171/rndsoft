class User < ApplicationRecord

  has_many :posts

  has_one :editor, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum digest_frequency: { ежедневно: 'daily', еженедельно: 'weekly', отказ: 'none' }

  validates :username, presence: true, uniqueness: true
  validates :email, uniqueness: true

  attribute :posts_count, :integer, default: 0

  def editor?
    self.editor.present?
  end

  def can_change_username?
    reload

    return true if last_username_change.nil?

    days_since_change = (Time.now - last_username_change) / 1.day
    puts "Days since last change: #{days_since_change}"
    days_since_change >= 5
  end

  def can_change_email?
    return true if last_email_change.nil?

    (Time.now - last_email_change) >= 5.days
  end

end

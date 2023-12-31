class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :posts, foreign_key: 'author_id'
  has_many :comments
  has_many :likes
  has_one_attached :photo

  enum role: { user: 'user', admin: 'admin' }

  def is?(requested_role)
    role == requested_role
  end

  def admin?
    role == 'admin'
  end

  def three_most_recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def photo_attached?
    photo.attached?
  end
end

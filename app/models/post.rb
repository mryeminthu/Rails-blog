class Post < ApplicationRecord
    belongs_to :author, class_name: 'User'
    has_many :comments
    has_many :likes
  
    def counters_update
      likes_counter_update
      comments_counter_update
    end
  
    def comments_counter_update
      update(comments_counter: comments.count)
    end
  
    def likes_counter_update
      update(likes_counter: likes.count)
    end
  
    def five_most_recent_comments
      comments.order(created_at: :desc).limit(5)
    end
  end
  
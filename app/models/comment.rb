class Comment < ApplicationRecord
  validates :body, presence: true, length: { minimum: 10, maximum: 500 }

  belongs_to :commentable, polymorphic: true
  belongs_to :user, class_name: "User", foreign_key: "user_id"
end

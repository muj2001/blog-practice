class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :body, presence: true, length: { minimum: 10, maximum: 2000 }

  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
end

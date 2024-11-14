class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :body, presence: true, length: { minimum: 10, maximum: 2000 }

  belongs_to :user
  has_and_belongs_to_many :category
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :sections
end

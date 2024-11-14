class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5, maximum: 50 }

  belongs_to :user, counter_cache: true
  has_and_belongs_to_many :category
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :sections, dependent: :destroy
end

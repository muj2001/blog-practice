class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }

  has_many :posts
end

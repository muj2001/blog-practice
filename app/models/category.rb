class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }

  has_and_belongs_to_many :posts
end

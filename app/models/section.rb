class Section < ApplicationRecord
  validates :body, presence: true, length: { minimum: 10, maximum: 500 }

  belongs_to :post
end

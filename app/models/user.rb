class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }

  has_secure_password

  has_and_belongs_to_many :subscribers, class_name: "User", join_table: "subscriptions", foreign_key: "subscriber_id"
  has_and_belongs_to_many :users, class_name: "User", join_table: "subscriptions", foreign_key: "user_id"

  has_many :posts, dependent: :destroy
  has_many :authored_comments, class_name: "Comment", foreign_key: "commenter_id", dependent: :destroy
  has_many :comments, class_name: "Comment", as: :commentable, dependent: :destroy

  def is_admin?
    admin
  end
end

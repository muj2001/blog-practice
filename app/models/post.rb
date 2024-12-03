class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5, maximum: 50 }

  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :sections, dependent: :destroy
  accepts_nested_attributes_for :sections, allow_destroy: true

  after_create :notify_subscribers

  private

  def notify_subscribers
    user.subscribers.each do |subscriber|
      SubscriptionMailer.new_post_notification(self, subscriber).deliver_later
    end
  end
end

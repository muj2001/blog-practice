module SubscriptionsHelper
  def subscribed?(user_sub)
    !!user_sub.subscribers.find_by(id: session[:user_id])
  end
end

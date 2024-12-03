class SubscriptionMailer < ApplicationMailer
  def new_post_notification(post, subscriber)
    @post = post
    @user = post.user
    @subscriber = subscriber

    mail(
      to: @subscriber.email,
      subject: "#{@user.name} has a new post!"
    )
  end
end

class UserMailer < ApplicationMailer
  default from: ENV["GMAIL_USERNAME"]

  def welcome_email(user)
    @user = user
    @url = "http://localhost:3000/login"
    mail(to: @user.email, subject: "Welcome to Blogs!")
  end

  def subscription_notification(post)
    @post = post
    @users = @post.user.subscribers
    @users.each do |user|
      mail(to: user.email, subject: "New Post by #{@post.user.name}") do |format|
        format.text { render "sub_email", locals: { user: user } }
      end
    end
  end
end

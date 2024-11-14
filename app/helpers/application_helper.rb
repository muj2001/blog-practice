module ApplicationHelper
  def logged_in?
    session[:user_id] ? true : false
  end

  def get_user
    user = User.find(session[:user_id])
    user
  end
end

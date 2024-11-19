module ApplicationHelper
  def logged_in?
    session[:user_id] ? true : false
  end

  def get_user
    User.find_by(id: session[:user_id])
  end
end

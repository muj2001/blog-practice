module ApplicationHelper
  def logged_in?
    session[:user_id] ? true : false
  end

  def get_user
    User.find_by(id: session[:user_id])
  end

  def is_admin_helper?
    if logged_in?
      User.find(session[:user_id]).is_admin?
    else
      false
    end
  end

  def is_user_s?(other)
    other.user.id == session[:user_id] ? true : false
  end
end

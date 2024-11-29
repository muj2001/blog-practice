module Authorization
  def logged_in?
    !!session[:user_id]
  end

  def authorize_user
    unless logged_in?
      redirect_to request.path, alert: "You must be logged in to perform this action."
      return false
    end
    true
  end

  def authorize_admin
    if authorize_user
      user = User.find(session[:user_id])
      unless user.is_admin?
        redirect_to request.path, alert: "You do not have this privelege."
      end
    end
  end

  def authorize_user_specific(other)
    if logged_in?
      unless other.user.id == session[:user_id]
        redirect_to request.path, alert: "You can not alter this."
      end
    end
  end
end

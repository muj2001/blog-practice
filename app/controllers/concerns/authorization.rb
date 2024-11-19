module Authorization
  def authorize_create
    p "Logged In? ---------------- #{session[:user_id]}"
    redirect_to root_path, alert: "Access denied" unless session[:user_id]
  end
end

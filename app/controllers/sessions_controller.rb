class SessionsController < ApplicationController
  # Login Form
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, log_success: "Logged in successfully!"
    else
      flash.now[:notify] = "Invalid email or password" # FLASH MESSAGES WORK WITHOUT TURBO
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, log_success: "Logged out successfully!"
  end
end

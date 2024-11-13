class SessionsController < ApplicationController
  # Login Form
  def new
  end

  def create
    p "----------------------------- #{params[:email]}"
    @user = User.find_by(email: params[:email])
    p "----------------------------- #{@user}"
    if @user&.authenticate(params[:password])
      p @user.id
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Logged in successfully!"
    else
      flash.now[:alert] = "Invalid email or password" # FLASH MESSAGES WORK WITHOUT TURBO
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully!"
  end
end

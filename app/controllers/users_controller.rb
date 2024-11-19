class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    # puts
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to "/", notice: "User successfully created!"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def sub
    @user = User.find(params[:id])
    @current_user = User.find(session[:user_id])

    unless @users.subscribers.include?(@current_user)
      @user.subcribers << @current_user
      if @user.save
        p "Subscribed ----------------------------"
        redirect_to @user, alert: "You have subscribed to #{@user.name}."
      else
        redirect_to @user, alert: "Error subscribing."
        p "Error Subscribing ----------------------------"
      end
    else
      redirect_to @user, alert: "Already subscribed to #{@user.name}."
      p "ALREADY SUBSCRIBED ----------------------------"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

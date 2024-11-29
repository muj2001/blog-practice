class UsersController < ApplicationController
  include Authorization

  before_action :authorize_user, only: [ :sub ]

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
      redirect_to root_path, notice: "User successfully created!"
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

    unless @user.subscribers.include?(@current_user)
      @user.subscribers << @current_user
      redirect_to @user, notice: "You have subscribed to #{@user.name}"
    else
      redirect_to @user, alert: "Already subscribed to #{@user.name}."
    end
  end

  def unsub
    @user = User.find(params[:id])
    @current_user = User.find(session[:user_id])

    if @user.subscribers.include?(@current_user)
      @user.subscribers.delete(@current_user)
      redirect_to @user, notice: "You have unsubscribed from #{@user.name}"
    else
      redirect_to @user, alert: "You are not subscribed to #{@user.name}"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

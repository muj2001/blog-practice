class PostsController < ApplicationController
  include Authorization

  before_action :authorize_user
  skip_before_action :authorize_user, only: [ :index, :show ]

  def index
    # @posts = Post.all
    p "#{params[:category_ids]} -----------------------------------------"
    if params[:category_ids].present?
      @posts = Post.joins(:categories).where(categories: { id: params[:category_ids] }).distinct
    else
      @posts = Post.all
    end
    @categories = Category.order(name: :asc)
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    if session[:user_id]
      if @post.save
        redirect_to root_path
      else
        redirect_to new_post_path, alert: "Could not create post"
      end
    else
      redirect_to new_post_path, alert: "You need to login to create a blog post."
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end

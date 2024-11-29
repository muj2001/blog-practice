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
    @post = Post.new(title: params[:title], user_id: session[:user_id])
    if @post.save
      if params[:category_ids].present?
        category_ids = params[:category_ids].map(&:to_i)
        @post.categories = Category.find(category_ids)
      end
      redirect_to edit_post_path(@post), notice: "Post created."
    else
      redirect_to new_post_path, alert: "Could not create post"
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    @categories = Category.all
  end

  def update
    @post = Post.find(params[:id])
    if params[:category_ids].present?
      category_ids = params[:category_ids].map(&:to_i)
      @post.categories = Category.find(category_ids)
    end
    unless @post.title == params[:title]
      @post.title = params[:title]
      if @post.save
        redirect_to @post, notice: "Edit successful."
      else
        redirect_to edit_post_path(@post), alert: "Edit not successful."
      end
    else
      redirect_to edit_post_path(@post), alert: "Equal Titles?"
    end
  end

  def destroy
  end

  def post_params
    params.permit(:title, category_ids: [])
  end
end

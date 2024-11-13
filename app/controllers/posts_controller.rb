class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
  end

  def create
  end

  def show
    @post = Post.find(params[:id])
    p "#{@post.title} --------------------"
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

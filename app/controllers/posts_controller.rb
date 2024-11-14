class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
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
    p "#{@post.title} --------------------"
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

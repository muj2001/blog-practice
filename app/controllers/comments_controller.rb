class CommentsController < ApplicationController
  include Authorization

  before_action :set_commentable
  before_action :authorize_user, only: [ :create, :destroy ]

  def create
    if session[:user_id]
      @comment = @commentable.comments.build(comment_params)
      @comment.user_id = session[:user_id]
      p @comment
      if @comment.save
        redirect_to @commentable
      else
        redirect_to @commentable, alert: "Comment not posted!"
      end
    else
        redirect_to login_path, alert: "You need to login to be able to comment."
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to @commentable, notice: "Comment deleted."
    else
      redirect_to @commentable, alert: "Could not delete comment!"
    end
  end

  def set_commentable
    if params[:post_id]
      @commentable = Post.find(params[:post_id])
    elsif params[:user_id]
      @commentable = User.find(params[:user_id])
    else
      head :bad_request
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end

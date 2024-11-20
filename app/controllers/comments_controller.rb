class CommentsController < ApplicationController
  before_action :set_commentable

  def create
    if session[:user_id]
      @comment = @commentable.comments.build(comment_params)
      @comment.commenter_id = session[:user_id]
      p "-----------Comment-----------"
      p @comment
      if @comment.save
        redirect_to @commentable
      else
        redirect_to @commentable, alert: "Comment not posted!"
      end
    else
        redirect_to login_path, alert: "You need to login to be able to comment."
    end
    #     @post = Post.find(params[:post_id])
    #     if session[:user_id]
    #       @comment = @post.comments.build(body: comment_params[:comment_body])
    #       @comment.commenter_id = session[:user_id]
    #       if @comment.save
    #         redirect_to post_path(@post)
    #       else
    #         redirect_to post_path(@post), alert: "Could not post comment!"
    #       end
    #     else
    #       redirect_to post_path(@post), alert: "You need to login to be able to comment."
    #     end
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

class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    if session[:user_id]
      @comment = @post.comments.build(body: comment_params[:comment_body])
      @comment.user_id = session[:user_id]
      if @comment.save
        p "Comment added!"
        redirect_to post_path(@post)
      else
        redirect_to post_path(@post), alert: "Could not post comment!"
      end
    else
      redirect_to post_path(@post), alert: "You need to login to be able to comment."
    end
  end

  def comment_params
    params.permit(:comment_body)
  end
end

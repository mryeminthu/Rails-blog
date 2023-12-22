class Api::CommentsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    user = User.find(params[:user_id])
    post = user.posts.find(params[:post_id])
    comments = post.comments
    render json: comments
  end

  def create
    post = Post.find(params[:post_id])
    User.find(comment_params[:user_id])
    comment = post.comments.new(text: comment_params[:text])
    respond_to do |format|
      if comment.save
        format.json { render json: comment, message: 'Create new comment' }
      else
        format.json { render json: comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :user_id)
  end
end

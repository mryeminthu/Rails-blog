class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params.merge(user: current_user))

    if @comment.save
      redirect_to user_post_path(@post.author, @post), notice: 'Comment added!'
    else
      render 'posts/show', alert: 'Unable to add comment.'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment
      @comment.destroy
      flash[:notice] = 'Comment was deleted'
    else
      flash[:notice] = 'Comment could not be found'
    end
    redirect_to user_posts_path(@post.author)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end

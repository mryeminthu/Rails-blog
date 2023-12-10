class LikesController < ApplicationController
  before_action :set_post, only: [:create]

  def create
    @user = User.find(params[:user_id])
    @like = Like.new(user: current_user, post: @post)

    if @like.save
      @post.update_columns(likes_counter: @post.likes_counter + 1)

      redirect_to user_post_path(@user, @post)
    else
      redirect_to user_post_path(@user, @post), alert: 'Unable to create like.'
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end

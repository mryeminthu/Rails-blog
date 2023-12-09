class LikesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @like = Like.new(user: current_user, post: @post)

    if @like.save
      @post.increment!(:likes_counter)
    end

    redirect_to user_post_path(@user, @post)
  end
end

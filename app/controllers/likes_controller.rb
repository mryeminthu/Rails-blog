class LikesController < ApplicationController
  def create
    @post = Post.find(params[:id])
    @post.increment!(:likes_counter)
  end
end

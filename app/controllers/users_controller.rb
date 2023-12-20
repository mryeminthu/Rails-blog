class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.three_most_recent_posts
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'User not found'
  end
end

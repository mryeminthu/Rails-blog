class PostsController < ApplicationController
  before_action :set_user, only: [:index, :show, :new, :create]
  before_action :set_post, only: [:show]

  def index
    @posts = @user.posts
  end

  def new
    @post = @user.posts.build
  end

  def create
    @post = @user.posts.new(post_params)

    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post created successfully!'
    else
      render 'new', alert: 'Unable to create post.'
    end
  end

  def show
    @comments = @post.comments
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end

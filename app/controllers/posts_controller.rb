class PostsController < ApplicationController
  before_action :set_post, only: [:show]
  before_action :set_user, only: %i[index show new create]

  def index
    @posts = @user.posts.includes(:comments).paginate(page: params[:page], per_page: 3)
    @post = @posts.first
    @recent_comment = @post.five_most_recent_comments if @post
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
    @user = @post.author
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find_by(id: params[:id])
    if @post
      @post.comments.destroy_all
      @post.destroy
      flash[:notice] = 'Post was deleted.'
    else
      flash[:alert] = 'Post could not be found.'
    end
    redirect_to user_posts_path(@user)
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

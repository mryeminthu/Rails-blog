require 'rails_helper'

RSpec.describe 'User Features', type: :feature do
  before do
    @author_user = User.create!(name: 'Ella', photo: 'https://example.com/ella_profile.png',
                                bio: 'Educator from Thailand.')
    @commenter_user = User.create!(name: 'Ye Min', photo: 'https://example.com/may_profile.png',
                                   bio: 'Student from Myanmar.')

    @post = Post.create!(title: 'Wayyyyy', text: 'Hello, this is my first post.', comments_counter: 0,
                         likes_counter: 2, author: @author_user)
    @comment = Comment.create(post: @post, user: @commenter_user, text: 'My meaningful comment.')
    @like = Like.create(post: @post, user: @commenter_user)
  end

  describe 'User Profile Page' do
    it "displays author's name" do
      visit user_posts_path(@commenter_user)
      expect(page).to have_content(@commenter_user.name)
    end

    it 'displays the username of each commenter' do
      comment = @post.comments.first
      expected_username = @commenter_user.name

      expect(comment.user.name).to eq(expected_username)
    end

    it "displays post's title" do
      visit user_posts_path(@commenter_user)
      expect(@post.title).to have_content('Wayyyyy')
    end

    it "displays post's body" do
      visit user_posts_path(@commenter_user)
      expect(@post.text).to have_content('Hello, this is my first post.')
    end

    it 'displays comments' do
      visit user_post_path(@commenter_user, @post)
      expect(@post.comments.map(&:text)).to include('My meaningful comment.')
    end

    it 'displays the number of comments' do
      visit user_post_path(@commenter_user, @post)
      expect(@post.comments.count).to have_content(1)
    end

    it 'displays the number of likes' do
      visit user_post_path(@commenter_user, @post)
      expect(@post.likes.count).to have_content(1)
    end
  end
end

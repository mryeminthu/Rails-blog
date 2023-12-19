require 'rails_helper'

RSpec.describe 'User Features', type: :feature do
  before do
    @first_user = User.create!(id: 5, name: 'Tom',
                               photo: 'https://upload.wikimedia.org/wikipedia/commons/4/41/Profile-720.png')
    @second_user = User.create!(id: 6, name: 'Lily',
                                photo: 'https://upload.wikimedia.org/wikipedia/commons/4/41/Profile-720.png')
    Post.create!(title: 'Post1', text: 'Hello there!', comments_counter: 0, likes_counter: 2, author: @first_user)
    Post.create!(title: 'Post2', text: 'Greetings!', comments_counter: 0, likes_counter: 2, author: @first_user)
    Post.create!(title: 'Post3', text: 'Hey everyone!', comments_counter: 0, likes_counter: 2, author: @second_user)
    Post.create!(title: 'Post4', text: 'Hello there!', comments_counter: 0, likes_counter: 2, author: @first_user)
    Post.create!(title: 'Post5', text: 'Greetings!', comments_counter: 0, likes_counter: 2, author: @first_user)
  end

  describe 'User Index Page' do
    it 'displays users\' names' do
      visit users_path
      expect(page).to have_content(@first_user.name)
      expect(page).to have_content(@second_user.name)
    end

    it 'displays users\' image links' do
      visit users_path
      expect(page).to have_css("img[src*='#{@first_user.photo}']")
      expect(page).to have_css("img[src*='#{@second_user.photo}']")
    end

    it 'displays the number of posts for each user' do
      visit users_path
      expect(@first_user.posts.count).to have_content(4)
      expect(@second_user.posts.count).to have_content(1)
    end

    it 'redirects to user show page' do
      visit users_path
      click_link(href: user_path(@first_user))
      sleep 15
      expect(current_path).to eq(user_path(@first_user))
    end
  end
end

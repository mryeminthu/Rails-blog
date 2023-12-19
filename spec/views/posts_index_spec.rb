require 'rails_helper'

RSpec.describe 'User Features', type: :feature do
  before do
    @officer = User.create!(id: 5, name: 'Officer',
                            photo: 'https://upload.wikimedia.org/wikipedia/commons/4/41/Profile-720.png',
                            bio: 'Law enforcement officer')
    @student = User.create!(id: 6, name: 'Student',
                            photo: 'https://upload.wikimedia.org/wikipedia/commons/4/41/Profile-720.png',
                            bio: 'High school student')

    Post.create!(title: 'Introduction', text: 'Hello, this is my introduction.', comments_counter: 0, likes_counter: 2,
                 author: @officer)
    Post.create!(title: 'Meeting new people', text: 'Hi, everyone! Nice to meet you.', comments_counter: 0,
                 likes_counter: 2, author: @officer)
    Post.create!(title: 'Police life', text: 'Sharing insights into my life as a police officer.', comments_counter: 0,
                 likes_counter: 2, author: @officer)
    Post.create!(title: 'Law enforcement challenges', text: 'Discussing challenges faced in law enforcement.',
                 comments_counter: 0, likes_counter: 2, author: @officer)
    Post.create!(title: 'Day in the life', text: 'Giving you a glimpse of my typical day.', comments_counter: 0,
                 likes_counter: 2, author: @officer)

    @student_post = Post.create!(title: 'First day at school', text: 'Exciting times on my first day!',
                                 comments_counter: 0, likes_counter: 2, author: @student)
    @comment1 = Comment.create(post: @student_post, user: @student, text: 'My comment on the student post')
    @like1 = Like.create(post: @student_post, user: @student)
  end

  describe 'User Profile Page' do
    it 'displays user profile information' do
      visit user_posts_path(@student)
      expect(page).to have_css("img[src*='#{@student.photo}']")
      expect(page).to have_content('Student')
    end

    it 'displays the number of posts' do
      visit user_posts_path(@student)
      expect(@student.posts.count).to have_content(1)
    end

    it 'displays a pagination button for posts' do
      visit user_posts_path(@officer)
      expect(page).to have_css('.pagination-button')
    end
  end

  describe 'User Post Page' do
    it 'displays post details' do
      visit user_posts_path(@student)
      expect(@student.posts[0].title).to have_content('First day at school')
      expect(@student.posts[0].text).to have_content('Exciting times on my first day!')
    end

    it 'displays the first comment and its count' do
      visit user_post_path(@student, @student_post)
      expect(page).to have_content('My comment on the student post')
      expect(@student.posts[0].comments.count).to have_content(1)
    end

    it 'displays the number of likes' do
      visit user_post_path(@student, @student_post)
      expect(@student.posts[0].likes.count).to have_content(1)
    end

    it 'redirects to the specific post when the user clicks on it' do
      visit user_path(@student)
      click_link @student_post.title
      expect(current_path).to eq(user_post_path(@student, @student_post))
    end

    it 'displays a section for pagination if there are more posts than fit on the view' do
      5.times do |n|
        Post.create!(title: "Test Post #{n + 1}", text: "Test post text #{n + 1}",
                     comments_counter: 0, likes_counter: 2, author: @student)
      end

      visit user_posts_path(@student)
      expect(page).to have_css('.pagination-button')
    end
  end
end

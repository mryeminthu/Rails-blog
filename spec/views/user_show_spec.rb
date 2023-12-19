require 'rails_helper'

RSpec.describe 'User Features', type: :feature do
  before do
    @law_enforcement_officer = User.create!(id: 5, name: 'Tom',
                                            photo: 'https://upload.wikimedia.org/wikipedia/commons/4/41/Profile-720.png',
                                            bio: 'Law enforcement officer')
    @high_school_student = User.create!(id: 6, name: 'Lily',
                                        photo: 'https://upload.wikimedia.org/wikipedia/commons/4/41/Profile-720.png',
                                        bio: 'High school student')

    Post.create!(title: 'Introductory Post', text: 'Hello, everyone!', comments_counter: 0, likes_counter: 2,
                 author: @law_enforcement_officer)
    Post.create!(title: 'Another Intro', text: 'Greetings!', comments_counter: 0, likes_counter: 2,
                 author: @law_enforcement_officer)
    Post.create!(title: 'Getting Started', text: 'Hi there!', comments_counter: 0, likes_counter: 2,
                 author: @law_enforcement_officer)
    Post.create!(title: 'Intro to the Community', text: 'Hi, all!', comments_counter: 0, likes_counter: 2,
                 author: @law_enforcement_officer)

    @student_post = Post.create!(title: 'Student Introduction', text: 'Hey, friends!', comments_counter: 0,
                                 likes_counter: 2, author: @high_school_student)
  end

  describe 'User Profile Page' do
    it 'displays specific user names' do
      visit user_path(@law_enforcement_officer)
      expect(page).to have_content('Tom')
      visit user_path(@high_school_student)
      expect(page).to have_content('Lily')
    end

    it 'displays users\' profiles' do
      visit user_path(@law_enforcement_officer)
      expect(page).to have_css("img[src*='#{@law_enforcement_officer.photo}']")
      visit user_path(@high_school_student)
      expect(page).to have_css("img[src*='#{@high_school_student.photo}']")
    end

    it 'displays the recent 3 posts for each user' do
      visit user_path(@law_enforcement_officer)
      expect(@law_enforcement_officer.three_most_recent_posts.count).to have_content(3)
      visit user_path(@high_school_student)
      expect(@high_school_student.posts.count).to have_content(1)
    end

    it 'displays the number of posts for each user' do
      visit user_path(@law_enforcement_officer)
      expect(@law_enforcement_officer.posts.count).to have_content(4)
      visit user_path(@high_school_student)
      expect(@high_school_student.posts.count).to have_content(1)
    end

    it 'displays the user\'s bio' do
      visit user_path(@law_enforcement_officer)
      expect(@law_enforcement_officer.bio).to have_content('Law enforcement officer')
      visit user_path(@high_school_student)
      expect(@high_school_student.bio).to have_content('High school student')
    end

    it 'displays a link to see all posts' do
      visit user_path(@law_enforcement_officer)
      expect(page).to have_content('See all posts')
    end

    it 'redirects to the user show page to see all posts' do
      visit user_path(@law_enforcement_officer)
      click_link('See all posts')
      sleep 15
      expect(current_path).to eq(user_posts_path(@law_enforcement_officer))
    end

    it 'redirects to the specific post when the user clicks on it' do
      visit user_path(@high_school_student)
      click_link @student_post.title
      sleep 15
      expect(current_path).to eq(user_post_path(@high_school_student, @student_post))
    end
  end
end

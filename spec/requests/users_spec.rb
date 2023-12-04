require 'rails_helper'

RSpec.describe 'User Management', type: :request do
  context 'User Index' do
    it 'responds successfully' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'displays a list of users' do
      get users_path
      expect(response.body).to include('<h1>A list of users</h1>')
    end
  end

  context 'User Details' do
    let(:sample_user) do
      User.create(
        name: 'Ye Min',
        photo: 'https://example.com/ye-min.jpg',
        bio: 'Software Engineer',
        posts_counter: 0
      )
    end

    it 'responds successfully' do
      get user_path(sample_user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get user_path(sample_user)
      expect(response).to render_template(:show)
    end

    it 'displays user information and posts' do
      get user_path(sample_user)
      expect(response.body).to include('<h2>User information and posts</h2>')
    end
  end
end

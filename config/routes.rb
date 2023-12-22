Rails.application.routes.draw do
  namespace :api do
    resources :users do
      resources :posts do
        resources :comments
      end
    end
  end
  devise_for :users

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  root 'users#index'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      post 'like', to: 'likes#create', on: :member, as: :like_post
      resources :comments, only: [:create, :new, :destroy]
    end
    get 'posts', to: 'posts#index', on: :member, as: :user_posts
  end
end

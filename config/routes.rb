Rails.application.routes.draw do
  root 'users#index'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show] do
      post 'like', to: 'likes#create', on: :member, as: :like_post
      resources :comments, only: [:create]
    end
  end
end

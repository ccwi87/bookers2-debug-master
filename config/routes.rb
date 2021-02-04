Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'

  resources :users, only: [:show, :index, :edit, :update,] do
    member do
     get :following, :followers
    end
  end
  resources :books do
    resource :favorites, only:[:create, :destroy]
    resources :book_comments, only:[:create, :destroy]
  end

  resources :relationships, only: [:create, :destroy]

  get 'search' => 'searches#search'

end
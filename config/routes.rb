Rails.application.routes.draw do
  root "users#feed"

  devise_for :users
  
  resources :comments, except: [:index, :show]
  resources :follow_requests
  resources :likes, only: [:create, :destroy]
  resources :photos, except: [:index]

  get ":username" => "users#show", as: :user
  get ":username/liked" => "users#liked", as: :liked
  get ":username/feed" => "users#feed", as: :feed
  get ":username/discover" => "users#discover", as: :discover
  get ":username/followers" => "users#followers", as: :followers
  get ":username/following" => "users#following", as: :following
end

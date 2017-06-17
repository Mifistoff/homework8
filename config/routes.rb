Rails.application.routes.draw do
  resources :projects
  root to: 'home#index'

  devise_for :users
end

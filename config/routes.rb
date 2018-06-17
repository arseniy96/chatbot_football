Rails.application.routes.draw do
  devise_for :admins
  root to: 'home#index'

  resources :posters, only: [:index, :show, :create]
end

Rails.application.routes.draw do
  devise_for :admins
  root to: 'home#index'

  resources :chants, only: [:index, :show, :create]
end

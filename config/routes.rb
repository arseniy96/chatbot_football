Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}
  devise_for :admins
  root to: 'home#index'

  resources :chants, only: [:index, :show, :create]
  get 'callback' => 'home#callback'
end

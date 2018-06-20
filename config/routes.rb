Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}
  devise_for :admins
  get 'callback' => 'home#callback'

  resources :users, only: [:index, :show] do
    resources :chants, only: [:index, :show, :create]
  end
end

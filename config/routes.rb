Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'devise/registrations' }
  resources :posts
  resources :users, only: [:new, :create, :edit, :update]
  resource :user, only: [:edit, :update] do
    get 'settings', on: :member
  end

  get 'statistics', to: 'statistics#index'

  root "posts#index"
end

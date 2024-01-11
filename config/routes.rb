Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'devise/registrations' }

  resources :posts
  resources :users, only: [:new, :create, :edit, :update] do
    get 'settings', on: :member
    member do
      get 'edit_username'
      patch 'update_username'
      get 'edit_email'
      patch 'update_username'
    end
  end

  get 'statistics', to: 'statistics#index'

  root "posts#index"
end

Rails.application.routes.draw do
  get 'meeting/new'
  get 'meeting/create'
  root 'pages#home'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#create'
  end

  get '/dashboard', to: 'pages#dashboard'
  get '/profile', to: 'pages#profile'
  get '/about', to: 'pages#about'

  resources :mentors, only: %i[index show]
end

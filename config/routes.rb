Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#create'
  end

  # resources :session, only: [:index]
  # resources :home, only: %i[index create]

  # Defines the root path route ("/")
  root 'pages#home'
end

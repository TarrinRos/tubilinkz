Rails.application.routes.draw do
  devise_for :users, controllers: {
    registration: 'registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :users, only: :show

  resources :links

  root to: 'pages#main'
  get '*short_url', to: 'links#open', as: :shortlink
end

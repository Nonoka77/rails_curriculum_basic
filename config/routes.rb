Rails.application.routes.draw do
  root 'static_pages#top'
  get 'static_pages/top', to: 'static_pages#top'
  get 'boards/index', to: 'boards#index'

  resources :users, only: %i[new create]

  get '/login', to: 'user_sessions#new', as: :login
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy', as: :logout

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

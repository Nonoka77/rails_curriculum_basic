Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  get 'profiles/show'
  get 'profiles/edit'
  get 'bookmarks/create'
  get 'bookmarks/destroy'
  root 'static_pages#top'
  get 'static_pages/top', to: 'static_pages#top'

  get '/login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  namespace :admin do
    root 'dashboards#index'
    get '/login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :users, only: %i[show edit update index destroy]
    resources :boards, only: %i[show edit update index destroy]
  end

  resources :users, only: %i[new create index]

  resource :profiles, only: %i[show edit update]

  resources :boards do
    resources :comments, only: %i[create destroy], shallow: true
    collection do
      get 'bookmarks'
    end
  end
  resources :bookmarks, only: %i[create destroy]

  resources :password_resets, only: %i[create new edit update]

  get '*path', controller: 'application', action: 'render_404'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

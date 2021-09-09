Rails.application.routes.draw do
  get 'bookmarks/create'
  get 'bookmarks/destroy'
  root 'static_pages#top'
  get 'static_pages/top', to: 'static_pages#top'
  
  get '/login', to: 'user_sessions#new', as: :login
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy', as: :logout
  
  resources :users, only: %i[new create index]
  
  resources :boards do
    resources :comments, only: %i[create destroy], shallow: true
    collection do
      get 'bookmarks'
    end
  end
  resources :bookmarks, only: %i[create destroy]

  get '*path', controller: 'application', action: 'render_404'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

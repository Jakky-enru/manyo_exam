Rails.application.routes.draw do
  get 'sessions/new'
  resources :sessions
  resources :users
  namespace :admin do
    resources :users
  end
  root to: 'tasks#index'
  resources :tasks do
    collection do
      get 'search'
    end
  end
end

Rails.application.routes.draw do
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

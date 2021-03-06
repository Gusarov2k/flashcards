Rails.application.routes.draw do
  resources :users, only: %i[show new edit create update]
  get '/sign_up', to: 'users#new', as: :sign_up

  resources :cards do
    member do
      patch 'word_comparison'
    end
    collection do
      get 'random'
    end
  end
  root 'cards#random'

  resources :sessions, only: %i[new create destroy]
  get '/log_in', to: 'sessions#new', as: :log_in
  delete '/log_out', to: 'sessions#destroy', as: :log_out

  resource :oauth do
    get :callback, on: :collection
  end

  get 'oauth/:provider' => 'oauths#oauth', as: :auth_at_provider

  resources :packs do
    member do
      patch 'current'
    end
  end
end

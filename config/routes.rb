Rails.application.routes.draw do
  resources :users, only: %i[show new edit create update] do
    collection do
      resources :cards, shallow: true do
        member do
          patch 'word_comparison'
        end
        collection do
          get 'random'
        end
      end
    end
  end
  get '/sign_up', to: 'users#new', as: :sign_up
  root 'cards#random'

  resources :sessions, only: %i[new create destroy]
  get '/log_in', to: 'sessions#new', as: :log_in
  delete '/log_out', to: 'sessions#destroy', as: :log_out
end

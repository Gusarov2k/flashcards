Rails.application.routes.draw do
  resources :cards do
    member do
      patch 'word_comparison'
    end
    collection do
      get 'random'
    end
  end
  root 'cards#random'
end

Rails.application.routes.draw do
  resources :cards do
    patch 'word_comparison'
  end
  root 'flash_cards#index'
end

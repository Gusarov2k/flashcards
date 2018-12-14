Rails.application.routes.draw do
  resources :cards do
    post 'word_comparison'
  end
  root 'flash_cards#index'
end

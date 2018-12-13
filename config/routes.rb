Rails.application.routes.draw do
  resources :cards
  root 'flash_cards#index'
  patch '/', to: 'cards#word_comparison'
end

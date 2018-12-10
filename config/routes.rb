Rails.application.routes.draw do
  resources :cards
  root 'flash_cards#index'
  post '/', to: 'flash_cards#index'
end

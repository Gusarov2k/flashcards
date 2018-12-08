Rails.application.routes.draw do
  resources :cards
  resource :flash_cards, only: %i[index create update]
  root 'flash_cards#index'
end

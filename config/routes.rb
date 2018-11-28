Rails.application.routes.draw do
  
  resources :cards

  root "flash_cards#index"
end

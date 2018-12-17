Rails.application.routes.draw do
  resources :cards do
    member do
      patch 'word_comparison'
    end
  end
  match 'cards/random' => 'cards#random', via: :get
  root 'cards#random'
end

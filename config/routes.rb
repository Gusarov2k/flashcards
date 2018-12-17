Rails.application.routes.draw do
  resources :cards do
    member do
      patch   'word_comparison'
      get     'check_translate'
    end
  end
  root 'cards#check_translate'
end

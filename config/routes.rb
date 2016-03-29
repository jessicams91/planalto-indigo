Rails.application.routes.draw do
  root 'home#index'

  resources :cards, only: [:show]
end

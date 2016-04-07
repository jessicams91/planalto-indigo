Rails.application.routes.draw do
  root 'home#index'

  resources :cards, only: [:show, :index] do
    collection { post :import }
  end
  resources :expansions, only: [:show, :index] do
    collection { post :import }
  end
end

Rails.application.routes.draw do
  root to: 'home#index'
  resources :personas, only: [:index, :show]
  resources :simulator, only: [:index]
end

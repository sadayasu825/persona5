Rails.application.routes.draw do
  get       '/login',   to: 'sessions#new'
  post      '/login',   to: 'sessions#create'
  delete    '/logout',  to: 'sessions#destroy'
  root                  to: 'home#index'
  resources :personas,  only: [:index, :show]
  resources :edit_all,  only: [:index, :update]
  resources :simulator, only: [:index]
end

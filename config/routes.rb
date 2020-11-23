Rails.application.routes.draw do
  root 'blocks#index'

  resources :blocks, only: [:index, :show]
  resources :transactions, only: [:index, :show]
end

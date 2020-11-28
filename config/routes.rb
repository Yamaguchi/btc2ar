Rails.application.routes.draw do
  root 'blocks#index'

  resources :blocks, only: [:index] do
    get ':blockhash', to: 'blocks#show', on: :collection
  end
  resources :transactions, only: [:index, :show]
end

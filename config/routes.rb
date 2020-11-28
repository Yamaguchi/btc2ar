Rails.application.routes.draw do
  resources :blocks, only: [:index] do
    get ':blockhash', to: 'blocks#show', on: :collection, as: :show
  end
  resources :transactions, only: [:index, :show]
end

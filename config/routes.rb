Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :products, only: [:create, :show, :update, :destroy]
      resources :stores, only: [:create, :show, :update, :destroy]
      resources :stock_items, only: [:create]
      patch 'stock_items', to: 'stock_items#add_quantity'
      delete 'stock_items', to: 'stock_items#remove_quantity'
    end
  end
end

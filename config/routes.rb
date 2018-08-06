Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :transactions, only: [:index, :edit, :update]
  resources :budgeted_line_items, only: [:index]
end

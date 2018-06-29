Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :transactions
  resources :budgeted_line_items
end

Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :accounts do
    resources :transactions, only: [:index, :edit, :update]
    resources :budgeted_line_items
    resources :import_file_requests, only: [:new, :create]
  end
end

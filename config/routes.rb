Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :accounts do
    resources :transactions, only: [:index, :edit, :update]
    resources :budgeted_line_items, only: [:index]
    resources :imported_files, only: [:new, :create]
  end
end

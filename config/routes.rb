Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: "devise/registrations#new"
  end

  resources :accounts, only: [:index, :edit, :update, :new, :create, :destroy] do
    resources :transactions, only: [:index, :edit, :update]
    resources :budgeted_line_items
    resources :import_file_requests, only: [:new, :create]
    resources :dashboard, only: [:index]
  end
end

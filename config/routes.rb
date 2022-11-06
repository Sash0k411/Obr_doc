Rails.application.routes.draw do
  root 'pages#main'
  get 'admin', to: 'admin/pages#main'
  namespace :admin do
    resources :categories
    resources :documents
  end

  namespace :api do
    resources :categories
    resources :documents
    resources :files
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
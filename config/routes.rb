Rails.application.routes.draw do

  NESTED_LEVEL = 4 # nested level of categories url


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

  get "/c", to: "categories#index"

  (1..NESTED_LEVEL).to_a.each do |level|
      categories_part = (1..level).to_a.map { |num| ":c_#{num}"}.join("/")
      get "/c/#{categories_part}/document/:slug", to: "documents#show"
      get "/c/#{categories_part}", to: "categories#show"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
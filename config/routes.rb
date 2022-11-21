Rails.application.routes.draw do

  NESTED_LEVEL = 4 # nested level of categories url


  root 'pages#main'
  get 'admin', to: 'admin/application#main'
  namespace :admin do
    resources :categories
    resources :documents  do
      collection do
        post :import
        get :other
        get :export
      end
    end
    resources :pages
  end

  namespace :api do
    resources :categories
    resources :documents
    resources :files
    resources :pages
  end

  get "/c", to: "categories#index"
  get "/sitemap", to: "application#sitemap"

  (1..NESTED_LEVEL).to_a.each do |level|
      categories_part = (1..level).to_a.map { |num| ":c_#{num}"}.join("/")
      get "/c/#{categories_part}/document/:slug", to: "documents#show"
      get "/c/#{categories_part}", to: "categories#show"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
Rails.application.routes.draw do
  devise_for :users
  root "articles#index"

  post "/search", to: "articles#search"
  get "/search", to: "articles#search"

  resources :articles do
    resources :comments
  end
end

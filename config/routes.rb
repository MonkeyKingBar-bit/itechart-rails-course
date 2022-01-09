Rails.application.routes.draw do
  devise_for :users
  resources :categories
  resources :transactions
  resources :people
  get "homepage", to: "home#homepage"
  root "people#index"
end

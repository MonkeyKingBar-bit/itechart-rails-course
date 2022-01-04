Rails.application.routes.draw do
  resources :notes
  devise_for :users
  resources :categories
  resources :money_transactions
  resources :people
  get "homepage", to: "home#homepage"
  root "people#index"
end

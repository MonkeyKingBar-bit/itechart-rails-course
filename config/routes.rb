Rails.application.routes.draw do
  resources :transactions
  devise_for :users
  resources :people
  get "homepage", to: "home#homepage"
  root "people#index"
end

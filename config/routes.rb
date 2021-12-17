Rails.application.routes.draw do
  resources :people
  devise_for :users
  # resources :users
  root "home#homepage"
  get "homepage", to: "home#homepage"
end

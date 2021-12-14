Rails.application.routes.draw do
  # get "persons/profile", as: "user_root"
  devise_for :users
  resources :users
  root "home#homepage"
  get "homepage", to: "home#homepage"
end

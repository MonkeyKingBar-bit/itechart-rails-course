Rails.application.routes.draw do
  get "persons/profile", as: "user_root"
  devise_for :users
  resources :users
  root "pages#home"
end

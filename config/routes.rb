Rails.application.routes.draw do
  devise_for :users
  resources :users, :only => [:show]
  resources :foods, :only => [:index, :new, :create, :edit, :update, :destroy]
  resources :menus
  get '/',  to:"top#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

Rails.application.routes.draw do
  devise_for :users
  resources :users, :only => [:show]
  resources :foods, :only => [:index, :new, :create, :edit, :update, :destroy]
  resources :recipes, :only => [:new, :create, :edit, :update, :destroy]
  resources :menus
  resources :orders, :only => [:index, :new, :create, :edit, :update, :destroy]
  get '/',  to: 'top#index'
  get 'order_search', to: 'orders#search'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

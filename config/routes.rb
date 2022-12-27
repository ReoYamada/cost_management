Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  resources :users, :only => [:index]
  resources :foods, :only => [:index, :new, :create, :edit, :update, :destroy]
  resources :recipes, :only => [:new, :create, :edit, :update, :destroy]
  resources :menus
  resources :orders, :only => [:index, :new, :create, :edit, :update, :destroy]
  get '/',  to: 'top#index'
  get 'order_search', to: 'orders#search'
  get 'user_search', to: 'users#search'
  post 'guest_sign_in', to: 'top#guest_sign_in'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

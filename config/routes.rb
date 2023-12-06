Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check
  # get 'home/index'
  get 'navigation_pages/home' => 'navigation_pages#home'
  get 'navigation_pages/help' => 'navigation_pages#help'
  get 'navigation_pages/about' => 'navigation_pages#about'
  get 'navigation_pages/contact' => 'navigation_pages#contact'
  get 'signup' => 'users#new'
  delete 'logout', to: 'sessions#destroy'

  put 'delete_user', to: 'users#delete'
  # get 'navigation_pages/contact'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  # delete 'logout'  => 'sessions#destroy'
  get 'logout' => 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  get 'select_seller' => 'sellers#select'
  post 'select_seller' => 'sellers#show'
  get 'edit_seller' => 'sellers#edit'
  post 'edit_seller' => 'sellers#edit'
  get 'new_seller' => 'sellers#new'
  resources :sellers

  resources :buyers

  # Defines the root path route ("/")
  # root "posts#index"
  # root "home#index"
  root 'navigation_pages#home'

  # Defines the route for the categories page
  resources :categories

  # Defines the route for the items page
  resources :items

  # Defines the routes for reviews
  resources :seller_reviews

  # Defines the routes for cart
  resources :carts, only: [:show] do
    post 'add/:item_id', to: 'carts#add', as: :add_to
    post 'remove/:item_id', to: 'carts#remove', as: :remove_from
  end
  # Defines the routes for purchases
  resources :purchases, only: [:new, :create]
end

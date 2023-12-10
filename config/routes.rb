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

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  resources :users
  get 'butter_user' => 'users#butter'

  resources :account_activations, only: [:edit]

  resources :password_resets, only: %i[new create edit update]

  get 'select_seller' => 'sellers#select'
  # post 'select_seller' => 'sellers#show'
  post 'select_seller' => 'sellers#selection_redirect'
  get 'edit_seller' => 'sellers#edit'
  post 'edit_seller' => 'sellers#edit'
  get 'new_seller' => 'sellers#new'
  get 'search_seller' => 'sellers#search'
  resources :sellers

  resources :buyers

  # Defines the root path route ("/")
  root 'navigation_pages#home'

  # Defines the route for the categories page
  resources :categories

  # Defines the route for the items page
  resources :items
  put 'items' => 'items#index'
  get 'search_item' => 'items#search'
  get 'butter_item' => 'items#butter'

  # Defines the routes for reviews
  resources :seller_reviews

  # Defines the routes for cart
  resources :carts, only: [:show] do
    post 'add/:item_id', to: 'carts#add', as: :add_to
    post 'remove/:item_id', to: 'carts#remove', as: :remove_from
  end

  # Defines the routes for purchases
  resources :purchases, only: %i[new create]
end

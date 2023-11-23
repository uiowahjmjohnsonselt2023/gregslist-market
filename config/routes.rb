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
  get 'delete_user', to: 'users#destroy'
  post 'delete_user', to: 'users#destroy'
  delete 'delete_user', to: 'users#destroy'
  # get 'navigation_pages/contact'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  # delete 'logout'  => 'sessions#destroy'
  get 'logout' => 'sessions#destroy'
  resources :users

  get 'select_seller' => 'sellers#select'
  post 'select_seller' => 'sellers#show'
  get 'edit_seller' => 'sellers#edit'
  post 'edit_seller' => 'sellers#edit'
  get 'new_seller' => 'sellers#new'
  resources :sellers

  # Defines the root path route ("/")
  # root "posts#index"
  # root "home#index"
  root 'navigation_pages#home'
end

Rails.application.routes.draw do
  resources :user_foods, only: [:index, :create, :destroy]
  resources :recipe_food, only: [:index, :create, :destroy]
  resources :recipes, only: [:index, :show, :new, :create, :destroy] do
    get 'publics', on: :collection
  end
  resources :foods, only: [:index, :show, :new, :create, :destroy]

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get '/current_user', to: 'current_user#index'
  
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "current_user#index"
end





  

  
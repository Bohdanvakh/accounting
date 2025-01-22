Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      post 'confirm_user', to: 'users#confirm_user', as: :confirm_user
      post 'verify_phone', to: 'sessions#authenticate_phone_number', as: :verify_phone
      post 'exit', to: 'sessions#set_user_active_false', as: :logout

      resources :users, only: [:create]
      resources :sessions, only: [:create]

      resources :users do
        resources :folders, only: [:index, :create, :show, :destroy]
      end
    end
  end
end

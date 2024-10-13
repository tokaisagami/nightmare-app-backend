Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :placeholders, only: [:index]
      resources :users, only: [:create]
      post 'login', to: 'user_sessions#create'
    end
  end
end

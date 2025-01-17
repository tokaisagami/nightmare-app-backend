Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :placeholders, only: [:index]
      resources :users, only: [:create, :show, :update] # :updateアクションを追加
      resources :password_resets, only: [:create, :edit, :update]
      post 'login', to: 'user_sessions#create'
      resources :nightmares, only: [:index, :show, :create, :update, :destroy] do
        collection do
          post :modify
        end
      end
    end
  end
end

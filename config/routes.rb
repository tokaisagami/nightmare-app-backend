Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :create, :update, :destroy]
    end
  end

  # 他のルートを定義する場合も同様に
  # namespace :api do
  #   namespace :v1 do
  #     resources :articles, only: [:index, :show, :create, :update, :destroy]
  #   end
  # end
end

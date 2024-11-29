Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?

  devise_for :users

  resources :users do
    resources :proponents do
      resources :phones, only: %i[index new create edit update destroy]
      resources :addresses, only: %i[index new create edit update destroy]
    end
  end

  root 'proponents#index'
end

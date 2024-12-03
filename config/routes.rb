Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?

  devise_for :users

  resources :users do
    resources :proponents
    resources :inss_discount_metrics, only: [:index]
  end

  root 'inss_discount_metrics#index'
end

Rails.application.routes.draw do
  root 'home#index'

  namespace :api do
    namespace :v1 do
      resources :status_messages, only: [:create]
    end
  end
end

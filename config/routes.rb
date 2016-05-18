Rails.application.routes.draw do
  root 'home#index'

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      post 'status_messages'          => 'status_messages#create'
      get  'status_messages/current'  => 'status_messages#current'
    end
  end
  apipie
end

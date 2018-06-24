Rails.application.routes.draw do
  get "/signup" => "users#new"
  get '/users' => 'users#index'
  get '/users' => 'users#new'
  get '/users/:id/:edit' => 'users#edit'
  patch '/users/:id' => 'users#update'
  delete '/users/:id' => 'users#destroy'
  get '/users/:id' => 'users#show'
  post '/users' => 'users#create'

  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  delete "/logout" => "sessions#destroy"

namespace :client do
      get '/car_parts' => 'car_parts#index'
      get '/car_parts/new' => 'car_parts#new'
      post'/car_parts' => 'car_parts#create'
      get '/car_parts/:id' => 'car_parts#show'
      get '/car_parts/:id/edit' => 'car_parts#edit'
      patch '/car_parts/:id' => 'car_parts#update'
      delete '/car_parts/:id' => 'car_parts#destroy'

      
      get '/car_services' => 'car_services#index'
      get '/car_services/new' => 'car_services#new'
      post'/car_services' => 'car_services#create'
      get '/car_services/:id' => 'car_services#show'
      get '/car_services/:id/edit' => 'car_services#edit'
      patch '/car_services/:id' => 'car_services#update'
      delete '/car_services/:id' => 'car_services#destroy'
      
      get '/car_parts' => 'car_parts#index'
      get '/car_parts/new' => 'car_parts#new'
      post'/car_parts' => 'car_parts#create'
      get '/car_parts/:id' => 'car_parts#show'
      get '/car_parts/:id/edit' => 'car_parts#edit'
      patch '/car_parts/:id' => 'car_parts#update'
      delete '/car_parts/:id' => 'car_parts#destroy'

      
      get '/cars' => 'cars#index'
      get '/cars/new' => 'cars#new'
      post '/cars' => 'cars#create'
      get '/cars/:id' => 'cars#show'
      get '/cars/:id/edit' => 'cars#edit'
      patch '/cars/:id' => 'cars#update'
      delete '/cars/:id' => 'cars#destroy'

      
      get '/maintenance_events' => 'maintenance_events#index'
      get '/maintenance_events/new' => 'maintenance_events#new'
      post'/maintenance_events' => 'maintenance_events#create'
      get '/maintenance_events/:id' => 'maintenance_events#show'
      get '/maintenance_events/:id/edit' => 'maintenance_events#edit'
      patch '/maintenance_events/:id' => 'maintenance_events#update'
      delete '/maintenance_events/:id' => 'maintenance_events#destroy'

      
      get '/maintenance_services' => 'maintenance_services#index'
      get '/maintenance_services/new' => 'maintenance_services#new'
      post'/maintenance_services' => 'maintenance_services#create'
      get '/maintenance_services/:id' => 'maintenance_services#show'
      get '/maintenance_services/:id/edit' => 'maintenance_services#edit'
      patch '/maintenance_services/:id' => 'maintenance_services#update'
      delete '/maintenance_services/:id' => 'maintenance_services#destroy'


      get '/parts' => 'parts#index'
      get '/parts/new' => 'parts#new'
      post'/parts' => 'parts#create'
      get '/parts/:id' => 'parts#show'
      get '/parts/:id/edit' => 'parts#edit'
      patch '/parts/:id' => 'parts#update'
      delete '/parts/:id' => 'parts#destroy'
  end
end
  
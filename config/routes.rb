Rails.application.routes.draw do
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  namespace :client do
    get '/parts' => 'parts#index'
    get '/parts/new' => 'parts#new'
    post '/parts' => 'parts#create'
    get '/parts/:id' => 'parts#show'
    get '/parts/:id/edit' => 'parts#edit'
    patch '/parts/:id' => 'parts#update'
    delete 'parts/:id' => 'parts#destroy'

    get '/maintenance_events/new' => 'maintenance_events#new'
    post '/maintenance_events' => 'maintenance_events#create'
    get '/maintenance_events/:id' => 'maintenance_events#show'
    get '/maintenance_events/:id/edit' => 'maintenance_events#edit'
    patch '/maintenance_events/:id' => 'maintenance_events#update'
    delete 'maintenance_events/:id' => 'maintenance_events#destroy' 
  end
end

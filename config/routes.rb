Rails.application.routes.draw do
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/home', to: 'sessions#home'
  root to: 'dairies#index'
  get '/dairies/draft', to: 'dairies#draft'
  resources :users do
    get :favorites, on: :collection
    get :dairies
    get :fav
  end
  resources :dairies do
    resource :favorites, only: [:create, :destroy]
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

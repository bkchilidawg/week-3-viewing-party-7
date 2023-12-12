Rails.application.routes.draw do
 root 'welcome#index'

  get '/login', to: 'users#login_form', as: 'login' # Use UsersController and a login_form action
  post '/login', to: 'users#login_user' # Use UsersController and a login_user action
  
  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  get '/users/:id/movies', to: 'movies#index', as: 'movies'
  get '/users/:user_id/movies/:id', to: 'movies#show', as: 'movie'

  resources :users, only: :show

  get '/users/:user_id/movies/:movie_id/viewing_parties/new', to: 'viewing_parties#new'
  post '/users/:user_id/movies/:movie_id/viewing_parties', to: 'viewing_parties#create'
end
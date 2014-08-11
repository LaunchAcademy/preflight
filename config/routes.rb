Preflight::Engine.routes.draw do
  get '/auth/:provider/callback' => 'sessions#create'
  post '/auth/:provider/callback' => 'sessions#create'

  namespace :admin do
    resources :campaigns
  end
  
  root 'sign_ups#new'
end

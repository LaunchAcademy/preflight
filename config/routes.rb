Preflight::Engine.routes.draw do
  get '/auth/:provider/callback' => 'sessions#create'
  post '/auth/:provider/callback' => 'sessions#create'

  namespace :admin do
    resources :campaigns
  end

  resources :subscribers, only: [:new, :create]

  resources :campaigns, only: [] do
    resources :subscribers, only: [:new, :create]
  end

  root 'subscribers#new'
end

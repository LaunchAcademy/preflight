Preflight::Engine.routes.draw do
  get '/auth/:provider/callback' => 'sessions#create'
  post '/auth/:provider/callback' => 'sessions#create'

  resource :admin, only: :show, controller: 'admins' do
    resources :campaigns, controller: 'admin/campaigns'
  end

  resources :subscribers, only: [:new, :create]

  resources :campaigns, only: [] do
    resources :subscribers, only: [:new, :create]
  end

  root 'subscribers#new'
end

Rails.application.routes.draw do
  root 'home#index'

  post 'console' => 'console#create', as: 'consoles'
  # resources :console, only: [:index, :create]

  resources :boards, only: [:show, :create, :index]

  namespace :api, defaults: {format: 'json'} do
    post 'kpis' => 'kpis#create'
  end
end

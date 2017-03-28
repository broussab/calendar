Rails.application.routes.draw do
  devise_for :users

  resources :meetings

  resources :users, only: [:index, :show]

  namespace :api, defaults: { format: :json } do
    match '/meetings', to: 'meetings#preflight', via: [:options]
    resources :meetings, only: [:create]
  end

  get 'daily' => 'home#daily'

  get 'weekly' => 'home#weekly'

  get 'instructions' => 'home#about'

  root 'home#index'
end

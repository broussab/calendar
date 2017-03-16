Rails.application.routes.draw do
  devise_for :users
  resources :meetings

  get 'daily' => 'home#daily'

  get 'weekly' => 'home#weekly'

  get 'instructions' => 'home#about'

  root 'home#index'
end

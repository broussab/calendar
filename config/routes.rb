Rails.application.routes.draw do
  resources :meetings

  get 'daily' => 'home#daily'

  get 'weekly' => 'home#weekly'

  get 'instructions' => 'home#about'

  root 'home#index'
end

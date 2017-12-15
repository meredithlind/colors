Rails.application.routes.draw do
  resources :users, only: [:show, :update, :edit]

  get 'signup', to: 'users#new', as: 'signup'
end

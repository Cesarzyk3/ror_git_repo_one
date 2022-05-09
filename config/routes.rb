Rails.application.routes.draw do
  root 'articles#index'
  
  resources :articles do
    resources :comments, only: %i[ create destroy ]
  end

  devise_for :users

  resources :users, only: %i[ show index destroy]

end

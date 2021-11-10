Rails.application.routes.draw do
  resources :comments do
    put :like, on: :member 
    put :dislike, on: :member
    get :reply, on: :member
  end
  resources :contributions do
    put :like, on: :member 
    put :dislike, on: :member
    get :show_news, on: :collection
  end
  devise_for :users
  get 'contribution/:id', to: 'contributions#show_one'
    
  get 'users/:id/edit', to: 'users#edit', as: 'users_edit'
  get 'users/:id/show', to: 'users#show', as: 'users_show'
  put 'users/:id/edit', to: 'users#update', as: 'users_update'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'contributions#index' 
end

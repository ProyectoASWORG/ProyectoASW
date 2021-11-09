Rails.application.routes.draw do
  resources :comments do
    get :reply, on: :member
  end
  resources :contributions do
    get :show_news, on: :collection
  end
  devise_for :users
  get 'users/:id/edit', to: 'users#edit', as: 'users_edit'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'contributions#index' 
end

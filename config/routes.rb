Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :comments do
    put :like, on: :member 
    put :dislike, on: :member
    get :reply, on: :member
    get :show_comments, on: :member, as: 'show'
    get :show_upvoted_comments, on: :member, as: 'show_upvoted'
  end
  resources :contributions do
    post ':token', to: 'contributions#create', on: :collection, as: 'create_contribution', constraints: { token: /[^\/]+/ }
    put :like, on: :member 
    put :dislike, on: :member
    get :show_news, on: :collection
    get :show_ask, on: :collection
    get :show_user, on: :member, as: 'show_user'
    get 'contribution/:id', to: 'contributions#show_one'
    get :show_upvoted_contributions, on: :member, as: 'show_upvoted_ctb'
    get '/contributions/new/:token', to: 'contributions#new', on: :collection, as: 'new_contribution', constraints: { token: /[^\/]+/ }
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'users/sign_in', to: 'users/sessions#new', as: :new_user_session
    get 'users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
    get 'users/:id/edit', to: 'users#edit', as: 'users_edit'
    get 'users/:id/show', to: 'users#show', as: 'users_show'
    put 'users/:id/edit', to: 'users#update', as: 'users_update'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'contributions#index' 

end

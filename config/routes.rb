HouseManager::Application.routes.draw do
  resources :users do
    member do
      get :confirm
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets, only: [:new, :edit, :create, :update]
  resources :houses
  resources :user_invitations, only: [:new, :create]

  resources :expenditures, only: [:create, :show]

  resources :expenditure_users do
    member do
      post :confirm_payment
      get :confirmation_accepted
    end
  end


  root              to: 'static_pages#home'

  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  match '/contact', to: 'static_pages#contact'
end

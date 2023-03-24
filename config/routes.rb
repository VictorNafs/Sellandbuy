Rails.application.routes.draw do
  devise_for :users
  resources :home, only: [:index]
  resources :payments, only: [:new, :create]

 
  resources :items do
    get 'checkout', on: :member
    post 'charge', on: :member

    resources :transactions, only: [:create]
  end

  root "home#index"
end

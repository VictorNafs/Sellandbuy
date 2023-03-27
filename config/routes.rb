Rails.application.routes.draw do

get 'checkout', to: 'checkout#show"
get, 'checkout/success', to 'checkout#succes' 
get, 'checkout/success', to 'checkout#succes' 
get, 'billing', to 'billing#show' 

  devise_for :users

  resources :home, only: [:index]

  scope 'admin', module: 'admin', as: 'admin' do
    resources :dashboard
  end

  resources :payments, only: [:new, :create]

  resources :items do
    get 'checkout', on: :member
    post 'charge', on: :member
    resources :transactions, only: [:create]
  end

  resources :users, only: [:destroy]

  root "home#index"


end

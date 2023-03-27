Rails.application.routes.draw do

get 'checkout', to: 'checkout#show"
get, 'checkout/success', to 'checkout#succes' 
get, 'checkout/success', to 'checkout#succes' 
get, 'billing', to 'billing#show' 

  devise_for :users

  resources :home, only: [:index]

  scope 'admin', module: 'admin', as: 'admin' do
    resources :dashboard, only: [:index]
    resources :users, only: [:index, :show, :edit, :update]
    resources :items, only: [:index, :show, :edit, :update]
  end

  resources :payments, only: [:new, :create]

  resources :items do
    get 'checkout', on: :member
    post 'charge', on: :member
    resources :transactions, only: [:create]
  end

  resources :users, only: [:show]

  root "home#index"


end

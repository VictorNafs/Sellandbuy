Rails.application.routes.draw do
  devise_for :users

  resources :home, only: [:index]

  scope 'admin', module: 'admin', as: 'admin' do
    resources :dashboard, only: [:index]
    resources :items, only: [:index, :show, :edit, :update]
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

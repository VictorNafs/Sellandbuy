Rails.application.routes.draw do
  resources :categories, except: :show
  devise_for :users
  resources :home, only: [:index]
  resources :payments, only: [:new, :create]

 
  resources :items, path: '/' do
    get 'checkout', on: :member
    post 'charge', on: :member
  
    resources :transactions, only: [:create]
  end
end


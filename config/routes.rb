Rails.application.routes.draw do
  resources :items
  devise_for :users
  resources :home, only: [:index]
  scope 'admin', module: 'admin', as: 'admin' do
    resources :dashboard, only: [:index]
    resources :items, only: [:index, :show, :edit, :update]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :payments, only: [:new, :create]
  # Defines the root path route ("/")
  root "home#index"

 
  resources :items do
    get 'checkout', on: :member
    post 'charge', on: :member
  end
  
  

end

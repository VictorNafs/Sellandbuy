Rails.application.routes.draw do

  get '/apropos', to: 'home#apropos'

  resources :user, only: [:dold, :order, :paid]
  get '/orders', to: 'user#order'
  get 'orders/paid', to: 'user#paid'
  get 'orders/sold', to: 'user#sold'

  resources :categories
  devise_for :users
  resources :home, only: [:index, :contact]
  get '/contact', to: 'home#contact'

  scope 'admin', module: 'admin', as: 'admin' do
    resources :dashboard, only: [:index]
    resources :users, only: [:index, :show, :edit, :update]
    resources :items, only: [:index, :show, :edit, :update]
  end

  resources :payments, only: [:new, :create]

  resources :items, path: '/' do
    get 'checkout', on: :member
    post 'charge', on: :member

    resources :transactions, only: [:create] do
      post 'checkout', on: :collection
      post 'stripe_checkout', on: :collection
    end
  end

 

 

end

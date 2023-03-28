Rails.application.routes.draw do

<<<<<<< HEAD
=======
  resources :categories, except: :show
>>>>>>> cb032a85e75604c24f9c5ed60b45e1942bfdeb7f

  devise_for :users

  resources :home, only: [:index]

  scope 'admin', module: 'admin', as: 'admin' do
    resources :dashboard, only: [:index]
    resources :users, only: [:index, :show, :edit, :update]
    resources :items, only: [:index, :show, :edit, :update]
  end

  resources :payments, only: [:new, :create]

 
  resources :items, path: '/' do
    get 'checkout', on: :member
    post 'charge', on: :member
  
    resources :transactions, only: [:create]
  end

end


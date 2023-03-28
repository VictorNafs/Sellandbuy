Rails.application.routes.draw do
<<<<<<< HEAD
  resources :categories

=======
>>>>>>> main
  resources :categories, except: :show
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

    resources :transactions, only: [:create] do
      post 'checkout', on: :collection
      post 'stripe_checkout', on: :collection
    end
  end
end

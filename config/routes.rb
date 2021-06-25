Rails.application.routes.draw do
  root 'products#index'

  #Route redefinitions
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  controller :users do 
    get 'favorites' => :show
  end

  resources :users, only: [:new, :create, :show]

  resources :products, only: [:index, :new, :create]

  resources :products do
    put :favorite, on: :member
  end

end

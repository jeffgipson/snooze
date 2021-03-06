Rails.application.routes.draw do
  resources :locations
  devise_for :users
  resources :signups
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'signups#index'
  # get 'login', to: 'signups#login'
  get 'dashboard', to: 'signups#dashboard'
  get 'all-signups', to: 'signups#all_signups'
  #match '/users/sign_up', :to => "devise/sessions#new", :via => [:get, :post]

  devise_scope :user do
    get '/sign-in' => "devise/sessions#new", :as => :login
  end
end

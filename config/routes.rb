Rails.application.routes.draw do
  resources :signups
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'signups#index'
end

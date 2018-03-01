Rails.application.routes.draw do
  devise_for :users
  root 'books#index'

  resources :books
  
  match 'search(/:search)', :to => 'books#search', :as => :search, via: [:get, :post]


  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

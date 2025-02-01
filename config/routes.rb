Rails.application.routes.draw do
  resources :transactions
  resources :credit_cards
  # Here we added routes for credit_cards and transactions 
  post '/auth/login', to: 'auth#login'

  get '/auth/current', to: 'auth#current'

  post '/signup', to: 'users#create'
 
  resources :products

  resources :credit_cards

end

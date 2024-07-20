Rails.application.routes.draw do
  resources :transactions
  resources :pokemons
  resources :users

  get 'me', to: 'users#show_me'
  get 'me/transactions', to: 'users#transactions'
  get 'me/pokemons', to: 'users#pokemons'

  get 'pokemon/:id/checkout', to: 'pokemons#checkout'
  post 'pokemon/:id/buy', to: 'pokemons#buy'
  post 'pokemon/:id/sell', to: 'pokemons#sell'
  get 'market/pokemons', to: 'pokemons#market'


  get "up" => "rails/health#show", as: :rails_health_check

end

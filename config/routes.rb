Rails.application.routes.draw do
  root 'items#index'

  resources :items,  only: [:index, :show]
  resources :orders, only: [:index, :show]
  resources :users,  only: [:index, :show]

  get '/search', to: "search#show", as: "search"

  namespace :api do
    namespace :v1 do
      resources :items
    end
  end
end

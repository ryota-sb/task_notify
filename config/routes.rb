Rails.application.routes.draw do
  root to: 'home#index'
  get '/about',     to: 'home#index'
  get '/weektask',  to: 'home#index'
  get '/monday',    to: 'home#index'
  get '/tuesday',   to: 'home#index'
  get '/wednesday', to: 'home#index'
  get '/thursday',  to: 'home#index'
  get '/friday',    to: 'home#index'
  get '/saturday',  to: 'home#index'
  get '/sunday',    to: 'home#index'
  get '/task',      to: 'home#index'

  post '/callback', to: 'linebot#callback'

  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :tasks, only: [:index, :create, :update, :destroy]
    end
  end
end

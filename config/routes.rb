Rails.application.routes.draw do
  root to: 'home#index'

  post '/callback', to: 'linebot#callback'

  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :tasks, only: [:index, :create, :update, :destroy]
    end
  end
end

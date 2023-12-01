Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :categories, only: [ :index, :create, :destroy] do
    collection do
      get 'add_a_category', to: 'categories#new', as: 'new'
    end
    resources :purchases, only: [:index, :show, :create, :destroy], path: 'transactions' do
      collection do
        get 'add_a_transaction', to: 'purchases#new', as: 'new'
      end
    end
  end

  resources :older_transactions, only: [:index]
  root to: 'splash#index'
end

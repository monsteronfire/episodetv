Rails.application.routes.draw do
  devise_for :users
  resources :episodes do
    collection do
      get :autocomplete
    end
  end
  resource :subscription
  resource :card
  root to: 'episodes#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

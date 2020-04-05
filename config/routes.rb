Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'static_pages#index'
  devise_for :users, controllers: { registrations: 'registrations'}
  resources :surveys
  resources :users, only: :show
  post 'set_frequency', to: "users#set_frequency"
end

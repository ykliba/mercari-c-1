Rails.application.routes.draw do
  root 'top#index'
  
  resources :items, only: [:index, :new, :edit]
end

Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'personal_rightings', to: 'users/registrations#new_personal_righting'
    post 'personal_rightings', to: 'users/registrations#create_next'
    get 'delivery_addresses', to: 'users/registrations#new_delivery_address'
    post 'delivery_addresses', to: 'users/registrations#create_information'
    get "sign_out", :to => "users/sessions#destroy"
  end
  root 'items#index'
  resources :users, only: :show do
    member do
      get 'erase'
    end
    collection do
      get 'done'
    end
  end
  resources :items, only: :show

end

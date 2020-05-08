Rails.application.routes.draw do

  get 'buyers/index'
  get 'buyers/done'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'personal_rightings', to: 'users/registrations#new_personal_righting'
    post 'personal_rightings', to: 'users/registrations#create_next'
    get 'delivery_addresses', to: 'users/registrations#new_delivery_address'
    post 'delivery_addresses', to: 'users/registrations#create_information'
  end

  root 'items#index'

  resources :items do
    resources :buyers, only: [:index] do
      collection do
        get 'done', to: 'buyers#done'
        post 'pay', to: 'buyers#pay'
      end
    end
  end

  resources :credit_cards, only: [:new, :show, :destroy] do
    collection do
      post 'pay', to: 'credit_cards#pay'
    end
  end
  
end

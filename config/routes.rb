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
  
  resources :items, only: :show do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'get_shipping_way'
    end
  end

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
  
  
  
  get 'buyers/index'
  get 'buyers/done'
  

end

Rails.application.routes.draw do

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
    collection do
      get  'buy/:id'=>  'items#buy', as: 'buy'
      post 'pay/:id'=>   'items#pay', as: 'pay'#httpメソッドはpostなので注意
      get  'done'=>      'items#done', as: 'done'
    end
  end

  resources :credit_card, only: [:create, :show, :edit] do
    collection do
      post 'delete', to: 'credit_card#delete'
      post 'show'
    end
    member do
      get 'confirmation'
    end
  end 
  
end

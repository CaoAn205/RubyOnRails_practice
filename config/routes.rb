Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users do
    resources :follows, only: [:index ,:create, :destroy], shallow: true
    resources :followeds, only: [:index ,:create, :destroy], shallow: true
    resources :rooms do
      resources :room_messages, only: [:index, :create, :destroy], shallow: true
    end
  end

  resources :posts, only: [:index, :create, :show, :edit, :update,:destroy] do
    resources :photos, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy], shallow: true
    resources :comments, only: [:index, :create, :destroy], shallow: true
    resources :bookmarks, only: [:create, :destroy], shallow: true
  end
end

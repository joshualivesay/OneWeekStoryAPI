Rails.application.routes.draw do
  resources :oneups
  resources :awards
  resources :invitations, only: [:index, :destroy, :show]
  resources :posts, only: [:update, :destroy]
  resources :stories do
    resources :posts, only: [:index, :create]
    resources :oneups, only: [:index, :create]
    resources :invitations, only: [:index, :create, :destroy, :update]

  end
  match 'stories/:story_id/invitations/:id', to: 'invitations#destroy', via: [:options]
  resources :users do
    resources :awards, only: [:index]
    resources :stories, only: [:index]
    resources :invitations, only: [:index]
  end
  post '/tokens', to: 'token#authenticate'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount ActionCable.server => '/cable'
end

Wedeltube::Application.routes.draw do
  devise_for :users

  resources :videos do
    resources :comments, :only => [ :create, :update, :destroy ]
    resources :favorites, :only => [ :create, :update, :destroy ]
    resources :tags, :only => [ :index, :show, :create, :update, :destroy ]
    resources :participants, :only => [ :create, :update, :destroy ]
    resource :user
    member do
      post 'add_tag'
      delete 'remove_tag'
    end
  end

  resources :users do
    resources :comments, :only => [ :create, :update, :destroy ]
    resources :favorites, :only => [ :create, :update, :destroy ]
    resources :videos
    resources :participants, :only => [ :create, :update, :destroy ]
  end

  resources :participants do
    resources :videos
    resource :user
  end

  resources :favorites do
    resource :user
    resource :video
  end

  resources :comments do
    resource :user
    resource :video
  end

  resources :tags, :only => [ :index, :show, :create, :update, :destroy ] do
    resources :taggings, :only => [ :create, :update, :destroy ]
  end

  root :to => "home#index"
end

Wedeltube::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}


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
    resources :favorites, :only => [ :index, :update ] do
      member do
        delete 'destroy_favindex'
        delete 'destroy_detail'
      end
      collection do
        post 'create_favindex'
        post 'create_detail'
      end
    end
    resources :videos
    resources :participants, :only => [ :create, :update, :destroy ]
  end

  resources :tags, :only => [ :index, :show, :create, :update, :destroy ] do
    resources :taggings, :only => [ :create, :update, :destroy ]
  end

  root :to => "home#index"
end

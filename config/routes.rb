Rails.application.routes.draw do
  
  resources :movies do
    resources :users, only: [:index, :show] do
      resources :posts do
        resources :comments, only: [:index, :show]
      end
    end
  end
  
  resources :books do
  	resources :users, only: [:index, :show] do
      resources :posts do
        resources :comments, only: [:index, :show]
      end
    end
  end

  resources :users, shallow: true do
  	resources :posts, only: [:index, :show]
  end
  resources :posts

  resources :posts do
        resources :comments
      end 
end
Rails.application.routes.draw do

  resources :movies do
    resources :users, only: [:index, :show] do
      member do
        get '/posts', to: 'posts#movie_post'
      end
      resources :posts do
        resources :comments, only: [:index, :show]
      end
    end
  end

  resources :books do
    resources :users, only: [:index, :show] do
      member do
        get '/posts', to: 'posts#book_post'
      end
      resources :posts do
        resources :comments, only: [:index, :show]
      end
    end
  end

  resources :users do
    member do
      get '/posts', to: 'posts#user_post'
    end
  end

  resources :posts

  resources :posts do
    resources :comments
  end 
  
end

Rails.application.routes.draw do
  resources :movies do
    resources :users do
      resources :posts
    end
  end
  resources :books do
  	resources :users do
      resources :posts
    end
  end
  resources :users do
  	resources :posts
  end
  resources :posts
end
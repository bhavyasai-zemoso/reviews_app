Rails.application.routes.draw do
    resources :movies do
  	resources :users
  end
  resources :books do
  	resources :users
  end
end
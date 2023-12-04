Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  #-----book------
  resources :books
  get 'publish_or_unpublish' => 'books#publish_or_unpublish', as: 'publish_or_unpublish'
end

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  resources :tokens

  #-----book------
  resources :books
  get 'publish_book' => 'books#publish_book', as: 'publish_book'
  get 'unpublish_book' => 'books#unpublish_book', as: 'unpublish_book'
  get 'calculate_book_price' => 'books#calculate_book_price', as: 'calculate_book_price'

  #-----Category------
  resources :categories
end

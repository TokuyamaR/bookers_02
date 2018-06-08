Rails.application.routes.draw do
  root "home#top"
  devise_for :users
  resources :posts
  resources :users, only:[:show, :edit, :update]

  get '/users/:id/books' => 'users#books', as: 'user_books'
  get '/users/:id/index' => 'users#index', as: 'user_index'

  get '/top' => 'home#top'
  get '/about' => 'home#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

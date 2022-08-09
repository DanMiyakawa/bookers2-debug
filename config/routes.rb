Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  get "search" => "searches#search"
  get "search_book" => "books#search_book"


  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]do
   resource :favorites, only: [:create, :destroy]
   resources :book_comments, only: [:create, :destroy]
 end

  resources :users, only: [:index,:show,:edit,:update]do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    get "search", to: "users#search"
  end
  resources :groups do
    get "join" => "groups#join"
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end
  
  resources :chats, only: [:show, :create]
  resources :groups, only: [:index, :show, :edit, :create, :update, :new, :show]
  get "search_book" => "books#search_book"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

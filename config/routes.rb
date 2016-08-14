Rails.application.routes.draw do
  resources :organizations
  resources :requests
  resources :cycles
  resources :projects
  devise_for :users
  root "pages#home"
  get "home", to: "pages#home", as: "home"
  get "inside", to: "pages#inside", as: "inside"
  
  get "posts", to: "pages#posts", as: "posts"
  get "posts/:id", to: "pages#show_post", as: "post"


  namespace :admin do
    root "base#index"
    resources :users, :cycles

    get "posts/drafts", to: "posts#drafts", as: "posts_drafts"
    get "posts/dashboard", to: "posts#dashboard", as: "posts_dashboard"
    resources :posts
  end
end

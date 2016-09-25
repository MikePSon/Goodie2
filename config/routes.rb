Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  resources :reviews
  resources :organizations
  resources :requests
  resources :cycles
  resources :projects
  devise_for :users

  devise_scope :user do
    get 'new_applicant', :to => 'devise/registrations#new_applicant'
  end

  get "home", to: "pages#home", as: "home"
  get "inside", to: "pages#inside", as: "inside"
  
  get "posts", to: "pages#posts", as: "posts"
  get "posts/:id", to: "pages#show_post", as: "post"


  namespace :admin do
    resources :users, :cycles
    root :to => 'base#index', as: :dash

    get "posts/drafts", to: "posts#drafts", as: "posts_drafts"
    get "posts/dashboard", to: "posts#dashboard", as: "posts_dashboard"
    resources :posts
  end

  namespace :programadmin do
    root :to => 'base#index', as: :dash
  end
  namespace :programmanager do
    root :to => 'base#index', as: :dash
  end
  namespace :applicant do
    root :to => 'base#index', as: :dash
    resources :requests
  end

  root "pages#home"

  # api routes
  get '/api/documentation' => 'api#documentation'
  get '/api/datatable' => 'api#datatable'
  get '/api/jqgrid' => 'api#jqgrid'
  get '/api/jqgridtree' => 'api#jqgridtree'
  get '/assets/i18n/:locale' => 'api#i18n'
  post '/api/xeditable' => 'api#xeditable'
  get '/api/xeditable-groups' => 'api#xeditablegroups'

  #Lock Screen
  get 'pages/lock'

  # CKEditor, WYSIWYG

end

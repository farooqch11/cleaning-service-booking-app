Rails.application.routes.draw do

  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection
    match '(search/:q/page/:page)', action: :index, via: [:post , :get ] , on: :collection
  end

  resources :events
  devise_for :users, :controllers => { sessions: 'users/sessions' , invitations: 'users/invitations'}, skip: [:sessions]

  devise_scope :user do
    get    "sign-in",  to: "devise/sessions#new",         as: :new_user_session
    post   "sign-in",  to: "devise/sessions#create",      as: :user_session
    delete "sign-out", to: "devise/sessions#destroy",     as: :destroy_user_session
    root to: "users/sessions#new"
  end

  scope module: :backend do
    namespace :admin do
      get    "dashboard",  to: "dashboard#index"
      resources :employees do
        match :search, to: 'employees#index', via: [:post , :get ], on: :collection
      end
      resources :customers do
        match :search, to: 'customers#index', via: [:post , :get ], on: :collection
        resources :customer_invoices
      end
      resources :calendar
      resources :invoices do
        post :download
      end
      resources :employee_invoices
      resources :customer_invoices
      resources :events
      resources :jobs do
        match :search, to: 'jobs#index', via: [:post , :get ], on: :collection
      end
    end

    namespace :employee do
      get    "dashboard",  to: "dashboard#index"
      get    "profile",  to:   "dashboard#profile"
      get  "profile/setting",  to: "dashboard#edit", as: 'edit'
      patch  "profile/setting",  to: "dashboard#update"
      resources :events, only: [:index]
    end
  end



end

Rails.application.routes.draw do

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
      resources :employees
      resources :customers
      resource  :calender
      resources :events
    end

    namespace :employee do
      get    "dashboard",  to: "dashboard#index"
      resources :events , only: [:index]
    end
  end



end

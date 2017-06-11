Rails.application.routes.draw do

  namespace :backend do
    namespace :employee do
      get 'dashboard/index'
    end
  end

  namespace :backend do
    namespace :admin do
      get 'calenders/index'
    end
  end

  devise_for :users, :controllers => { sessions: 'users/sessions' }

  devise_scope :user do
    root to: "users/sessions#new"
  end

  scope module: :backend do
    namespace :admin do
      get    "dashboard",  to: "dashbored#index"
      resources :employees
      resources :customers
      resource  :calender
    end
  end



end

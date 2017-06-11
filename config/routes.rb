Rails.application.routes.draw do
  devise_for :users, :controllers => { sessions: 'users/sessions' }

  devise_scope :user do
    root to: "users/sessions#new"
  end

  scope module: :backend do
    namespace :admin do
      get    "dashboard",  to: "dashbored#index"
      resources :employees
    end
  end



end

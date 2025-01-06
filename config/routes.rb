Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'public/users/registrations',
    sessions: 'public/users/sessions'
  }
  devise_for :admins, path: 'admin', controllers: {
    sessions: 'admin/admins/sessions'
  }
  
  scope module: :public do
    root to: 'homes#top'
    get 'about', to: 'homes#about'
    resources :users, only: [:show, :edit, :update, :destroy]
    resources :posts
  end

  namespace :admin do
    root to: 'users#index'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

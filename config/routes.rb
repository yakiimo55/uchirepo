Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'public/users/registrations',
    sessions: 'public/users/sessions'
  }
  devise_for :admins, path: 'admin',
    skip: [:registerable, :recoverable],
    controllers: {
      sessions: 'admin/admins/sessions'
    }
  
  scope module: :public do
    root to: 'homes#top'
    get 'about', to: 'homes#about'
    resources :users, only: [:show, :edit, :update, :destroy]
    post 'guest_login', to: 'users#guest_login'
    resources :posts do
      resources :post_comments, only: [:create, :index, :destroy]
    end
  end

  namespace :admin do
    root to: 'users#index'
    resources :users, only: [:index, :show, :destroy]
    resources :posts, only: [:index, :destroy]
    resources :post_comments, only: [:index, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

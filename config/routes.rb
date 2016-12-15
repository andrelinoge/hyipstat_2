Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  devise_for :user

  namespace :admin do
    get '/', to: 'dashboard#index'
    resources :articles
    resources :article_categories
    resources :hyip_categories
    resources :hyips
    resources :pages, except: [:new, :create, :destroy]
    resources :users

    #resources :sessions, only: [:new, :create]

    devise_for :user, only: [:sessions], controllers: {
      sessions: 'admin/sessions'
    }
  end

  scope :locale do
  end

  root 'welcome#index'

  #devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

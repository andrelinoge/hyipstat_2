Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :user, controllers: { sessions: 'admin/sessions' }, skip: [:registrations]

  namespace :admin do
    get '/', to: 'dashboard#index'
    resources :articles
    resources :article_categories
    resources :hyip_categories
    resources :hyips
    resources :pages, except: [:new, :create, :destroy]
    resources :users

    resources :sessions, only: [:new, :create]
  end

  scope :locale do
    root 'welcome#index'
  end

  #devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

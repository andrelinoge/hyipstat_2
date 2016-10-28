Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  namespace :admin do
    get '/', to: 'dashboard#index'
    resources :articles
    resources :article_categories
    resources :hyip_categories
    resources :hyips
  end
  root 'welcome#index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

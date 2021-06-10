Rails.application.routes.draw do
  get 'welcome/index'

  resources :customers

  root to: 'welcome#index'
end

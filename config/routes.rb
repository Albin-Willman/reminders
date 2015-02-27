Rails.application.routes.draw do
  resources :subscribers

  resources :tasks
  root 'tasks#due_tasks'

  get 'login', to: 'subscribers#login'
  post 'login', to: 'subscribers#login_submit'
end

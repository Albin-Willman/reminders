Rails.application.routes.draw do
  resources :subscribers

  resources :tasks
  root 'tasks#due_tasks'
end

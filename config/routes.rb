OliveViewTools::Application.routes.draw do
  resources :reminder_lists
  resources :reminders
  resources :dc_summaries
  
  match 'phi(/:action)' => 'phi'
  
  devise_for :users
  root :to => 'dashboard#index'
  
  # admin area
  namespace :admin do |admin|
      resources :dashboard
  end

end

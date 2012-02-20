OliveViewTools::Application.routes.draw do

  get "sign_out/index"

  resources :prescriptions
  resources :consults
  
  resources :reminder_lists
  match 'reminder_lists/cancel_edit/:id' => 'reminder_lists#cancel_edit'

  resources :reminders
  match 'reminders/cancel_edit/:id' => 'reminders#cancel_edit'
  match 'reminders/create_by_string' => 'reminders#create_by_string'
  
  resources :dc_summaries
  match 'dc_summaries/:id/consults(.:format)' => 'dc_summaries#consults'
  match 'dc_summaries/:id/prescriptions(.:format)' => 'dc_summaries#prescriptions'
  match 'dc_summaries/:id/unfinalize' => 'dc_summaries#unfinalize'
  
  match 'phi(/:action)' => 'phi'
  match 'sign_out(/:action)' => 'sign_out'
  
  devise_for :users
  
  # admin area
  namespace :admin do |admin|
      resources :dashboard
      resources :sign_outs
      match 'users/:id/:action' => 'users'
  end
  
  # twilio receive sms
  match 'sms' => 'sms#index'

  match 'search(/:mrn)' => 'dashboard#search'
  
  root :to => 'dashboard#index'
end

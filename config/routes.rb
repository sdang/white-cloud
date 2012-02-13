OliveViewTools::Application.routes.draw do
  get "sign_out/index"

  resources :reminder_lists
  match 'reminder_lists/cancel_edit/:id' => 'reminder_lists#cancel_edit'

  resources :reminders
  match 'reminders/cancel_edit/:id' => 'reminders#cancel_edit'
  resources :dc_summaries
  
  match 'phi(/:action)' => 'phi'
  match 'sign_out(/:action)' => 'sign_out'
  
  devise_for :users
  
  # admin area
  namespace :admin do |admin|
      resources :dashboard
      resource :sign_outs
  end
  
  # twilio receive sms
  match 'sms' => 'sms#index'

  root :to => 'dashboard#index'
end

Rails.application.routes.draw do
  # get 'channel_emails/index'
  root to: 'tickets#index'

  resources :channel_emails do
    collection do
      post :probe
    end
  end

  resources :tickets do
    collection do
      get :download
      post :send_reply
      get :get_options
    end
  end

  resources :ticket_types
  resources :ticket_priority
  resources :calendars
  resources :groups
  resources :organizations
  resources :slas
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

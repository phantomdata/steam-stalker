Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  resource :dashboard, controller: 'dashboard'

  root 'dashboard#show'
end

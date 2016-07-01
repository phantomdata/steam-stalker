Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  resource :dashboard, controller: 'dashboard'
  resources :watched_steam_profiles

  root 'dashboard#show'
end

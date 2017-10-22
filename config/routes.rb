Rails.application.routes.draw do
  root 'dashboard#index'

  get 'dashboard', to: 'dashboard#index'
  get 'timeline', to: 'dashboard#timeline'
  get 'styleguide', to: 'dashboard#styleguide'
end

Rails.application.routes.draw do
  root 'dashboard#index'

  get 'dashboard', to: 'dashboard#index'
  get 'timeline', to: 'dashboard#timeline'
  get 'goals', to: 'dashboard#goals'
  get 'pomodoros', to: 'dashboard#pomodoros'
end

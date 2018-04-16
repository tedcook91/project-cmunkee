Rails.application.routes.draw do
  resources :stocks
  root "stocks#new"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  resources :clouds, except: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

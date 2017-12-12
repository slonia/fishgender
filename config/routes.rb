Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :words, except: [:show]
  resources :photos, except: [:edit, :update, :show] do
    member do
      post :activate
      post :deactivate
    end
  end
  root 'photos#index'
end

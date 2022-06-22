Rails.application.routes.draw do

  # get 'signup/create'

  namespace :api do
    namespace :v1 do

      resources :records
      resources :artists

    end
  end

  root 'home#index'


  post "refresh", controller: :refresh, action: :create
  post "signin", controller: :signin, action: :create
  post "signup", controller: :signup, action: :create
  delete "signin", controller: :signin, action: :destroy

end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

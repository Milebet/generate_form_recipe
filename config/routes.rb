Rails.application.routes.draw do
  get 'info/medline'
  get 'info/services'
  get 'info/ipe'
  get 'info/team'
  resources :recipes
  get 'home/index'
  get 'home/info'
  match "profile_doctor/:id" => "doctors#show", via: [:get], as: "profile_doctor"
  match "doctors/:id/my_recipes" => "doctors#my_recipes", via: [:get], as: "my_recipes"
  #match "doctors/:id/create_recipe" => "doctors#create_recipe", via: [:post], as: "create_recipe"
  devise_for :doctors, path:'doctors', :controllers => {
    sessions: 'doctors/sessions',
    confirmations: 'doctors/confirmations',
    passwords: 'doctors/passwords',
    registrations: 'doctors/registrations',
    unlocks: 'doctors/unlocks',
    omniauth: 'doctors/omniauth'
  }

  namespace :api do
    namespace :v1 do
      resources :doctors, only: [:update, :show]
      resources :recipes, only: [:index, :show]
    end
  end
  match "api/v1/update_doctor/:id" => "api/v1/doctors#update", via: [:put], as: "update_doctor_api"
  match "api/v1/validate_doctor/:email" => "api/v1/doctors#validate_doctor", via: [:get], constraints: { email: /[^\/]+/} , as: "validate_doctor"

  root to: "home#index"
end

Rails.application.routes.draw do
  root to: "home#index"
  get 'info/medline'
  get 'info/services'
  get 'info/ipe'
  get 'info/team'
  get 'home/index'
  get 'home/info'
  resources :recipes
  devise_for :doctors, path:'doctors', :controllers => {
    sessions: 'doctors/sessions',
    confirmations: 'doctors/confirmations',
    passwords: 'doctors/passwords',
    registrations: 'doctors/registrations',
    unlocks: 'doctors/unlocks',
    omniauth: 'doctors/omniauth'
  }
  match "profile_doctor/:id" => "doctors#show", via: [:get], as: "profile_doctor"
  match "doctors/:id/my_recipes" => "doctors#my_recipes", via: [:get], as: "my_recipes"
  namespace :api do
    namespace :v1 do
      resources :doctors, only: [:update, :show]
      resources :recipes, only: [:index, :show, :create]
    end
  end
  match "api/v1/update_doctor/:id" => "api/v1/doctors#update", via: [:put], as: "update_doctor_api"
  match "api/v1/validate_doctor/:email" => "api/v1/doctors#validate_doctor", via: [:get], constraints: { email: /[^\/]+/} , as: "validate_doctor"
  match "api/v1/recipes_doctor/:doctor_id" => "api/v1/recipes#recipes_doctor", via: [:get] , as: "recipes_doctor"
end

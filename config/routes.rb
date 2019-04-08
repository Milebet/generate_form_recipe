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
      resources :sessions, only: [:create]
      resources :doctors, only: [:create, :show, :index] do
        resources :recipes, only: [:index, :show]
      end
    end
  end

  root to: "home#index"
end

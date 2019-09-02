Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'

  get 'my_recipes', to: "recipes#my_recipes"
  resources :recipes, only: %i[index show new create edit update destroy] do 
    resources :recipe_lists, only: %i[create]  
    get 'search', on: :collection
    get 'my_recipes', on: :collection
    get 'control_recipes',on: :collection
    member do
      post 'accept'
      post 'declined'
    end
  end

  resources :recipe_types,only: %i[show new create]
  resources :lists,only: %i[index show new create] do
    resources :recipe_lists, only: %i[destroy]  
  end
  get 'control_recipes', to: "recipes#control_recipes"

  #API
  namespace :api ,defaults: { format: 'json' } do
    namespace :v1,defaults: { format: 'json' } do
      resources :recipes,      only: %i[create show destroy index] do
        member do
          post 'accepted'
          post 'declined'
        end
      end
      resources :recipe_types, only: %i[create show]
    end
  end
  
end

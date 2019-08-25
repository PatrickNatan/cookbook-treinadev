Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  get 'my_recipes', to: "recipes#my_recipes"
  resources :recipes, only: %i[index show new create edit update] do 
    get 'search', on: :collection
  end
  resources :recipe_types,only: %i[show new create]
  resources :lists,only: %i[index show new create]
  resources :recipe_lists, only: %i[create destroy]
end

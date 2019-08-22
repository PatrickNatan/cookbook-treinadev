Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  get 'search', to: 'recipes#search'
  get 'my_recipes', to: "recipes#my_recipes"
  resources :recipes, only: %i[index show new create edit update]
  resources :recipe_types,only: %i[show new create]
end

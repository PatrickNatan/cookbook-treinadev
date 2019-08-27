Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  get 'my_recipes', to: "recipes#my_recipes"
  resources :recipes, only: %i[index show new create edit update] do 
    get 'search', on: :collection
    resources :recipe_lists, only: %i[create]  
  end
  resources :recipe_types,only: %i[show new create]
  resources :lists,only: %i[index show new create] do
    resources :recipe_lists, only: %i[destroy]  
  end

end

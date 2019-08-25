class RecipeListsController < ApplicationController
    def create
    @list = List.find(params[:recipe_list][:list_id])
    @recipe = Recipe.find(params[:recipe_list][:recipe_id])
    @recipe_list = RecipeList.create(recipe: @recipe, list: @list)
    @recipe_list.save
    end
end

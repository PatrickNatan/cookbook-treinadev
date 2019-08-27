class RecipeListsController < ApplicationController
    def create
    @list = List.find(params[:recipe_list][:list_id])
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_list = RecipeList.create(recipe: @recipe, list: @list)
        if @recipe_list.save
            redirect_to @recipe
        else
            flash[:failure]="Essa receita já foi adicionada a essa lista "
            redirect_to @recipe
        end

    end

    def destroy
        @recipe = Recipe.find(params[:id])
        @list = List.find(params[:id]) 

        @recipe_list = RecipeList.find_by(recipe: @recipe, list: @list)
        @recipe_list.destroy

        redirect_to @list
    end
end

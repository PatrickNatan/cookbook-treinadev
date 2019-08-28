class Api::V1::RecipesController < ActionController::API
    def show
        @recipe = Recipe.find(params[:id])
        render json: @recipe, status: :ok
    end
end

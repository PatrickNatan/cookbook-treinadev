class Api::V1::RecipeTypesController < Api::V1::ApiController
    def create
      @recipe_type = RecipeType.new(params_recipe_type)
      if @recipe_type.save
        render json: 'Tipo de receita criada com sucesso', status: :created
      else
        render json: @recipe_type.errors.full_messages, status: 406
      end
    end

    def show
        @recipe_type = RecipeType.find(params[:id])
        render json: @recipe_type.to_json(include: :recipes), status: 200
    end
    
    private
    def params_recipe_type
      params.require(:recipe_type).permit(:name)
    end
end
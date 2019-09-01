class Api::V1::RecipesController < Api::V1::ApiController
    before_action :find_recipe, only: %i[show destroy accepted declined]
    def index
        if params[:status] 
         @recipes = Recipe.where(status: params[:status])
        else
         @recipes = Recipe.all
        end

        if @recipes != []
            render json: @recipes, status: :ok
        else
            render json: '', status: 404   
        end
    end

    def show
        render json: @recipe, status: :ok
    end

    def create
        @recipe = Recipe.new(params_recipe)
        if @recipe.save
          render json: { msg: 'Receita criada com sucesso', recipe: @recipe } , status: :created
        else
          render json: @recipe.errors.full_messages, status: 412
        end
    end
    
    def destroy
        @recipe.destroy
        render json:'',status:204
    end

    def accepted
        @recipe.accepted! unless @recipe.accepted?
        render json: @recipe, status: :ok
    end

    def declined
        @recipe.declined! unless @recipe.declined?
        render json: @recipe, status: :ok
    end

    private
    def params_recipe
        params.require(:recipe).permit(:title, :recipe_type_id, :cuisine, :difficulty, :cook_time, :cook_method, :ingredients,:user_id)
    end

    def find_recipe
        @recipe = Recipe.find(params[:id])
    end

    
end

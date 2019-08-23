class RecipeTypesController <  ApplicationController
 
  def show
    @recipe_type = RecipeType.find(params[:id])
  end

  def new
    @recipe_type = RecipeType.new
  end

  def create
    @recipe_type =  RecipeType.new(params_recipe_type)
    if @recipe_type.save
      redirect_to @recipe_type
    else
      render :new
    end
  end

  private

  def params_recipe_type
    params.require(:recipe_type).permit(:name)
  end
end

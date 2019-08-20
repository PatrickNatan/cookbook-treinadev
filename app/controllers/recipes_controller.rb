class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe =  Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      flash.now[:alert]= 'Não foi possível salvar a receita'
      render :new
    end
  end
  
  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      flash.now[:alert]= 'Não foi possível salvar a receita '
      render :edit
    end
  end
  
  def search
    @recipes = Recipe.where('title LIKE ?', "%#{params[:q]}%")
    if @recipes.empty?
      flash[:alert] = "Não foi possível encontrar a receita"
      redirect_to root_path
    end
  end

  private
  def recipe_params
    params.require(:recipe).permit(:title,:recipe_type_id,:cuisine,:difficulty,:cook_time,:ingredients,:cook_method)
  end
end

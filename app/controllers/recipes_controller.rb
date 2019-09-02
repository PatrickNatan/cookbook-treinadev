class RecipesController < ApplicationController
  before_action :authenticate_user!,only: %i[new create edit update my_recipes destroy]
  before_action :find_recipe,only: %i[show edit update accept declined destroy]

  def index
    @recipes = Recipe.where(status: [:accepted])
  end

  def show
    if current_user
    @lists = current_user.lists
    @recipe_list = RecipeList.new
    end
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe =  Recipe.new(recipe_params)
    @recipe.user= current_user
    if @recipe.save
      redirect_to @recipe
    else
      flash.now[:alert]= 'Não foi possível salvar a receita'
      render :new
    end
  end
  
  def edit
    unless current_user.recipe_owner?(@recipe)
      redirect_to root_path
    end
  end

  def update
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
      flash[:alert] = 'Não foi possível encontrar a receita'
      redirect_to root_path
    end
  end

  def my_recipes
    if current_user.recipes.empty?
      flash[:alert] = 'Você não tem receitas cadastradas'
      redirect_to root_path
    end
    @recipes= current_user.recipes
  end

  def control_recipes
    @recipes = Recipe.where(status:[:pending])
  end

  def accept
    @recipe.accepted!
    flash[:notice] = "#{@recipe.title} aceita"
    redirect_to control_recipes_path
  end

  def declined
    @recipe.declined!
    flash[:notice] = "#{@recipe.title} rejeitada"
    redirect_to control_recipes_path
  end

  def destroy
    unless current_user.recipe_owner?(@recipe)
      redirect_to root_path
    else
      @recipe.destroy
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title,:recipe_type_id,:cuisine,:difficulty,:cook_time,:ingredients,:cook_method,:recipe_img)
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])    
  end
end

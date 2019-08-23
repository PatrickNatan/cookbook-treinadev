require 'rails_helper'

describe RecipeList do
  describe "recipe belongs to list" do
    it "list can have many recipes" do
      user = User.create!(email:"abc@email.com", password:"123456")
      recipe_type = RecipeType.create(name: 'Sobremesa')
      recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: 'Brasileira', difficulty: 'Médio',
      cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user: user)
      other_recipe = Recipe.create(title: 'Chocolate', recipe_type: recipe_type,
      cuisine: 'Brasileira', difficulty: 'Médio',
      cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user: user)
      list = List.create!(name: "doceria", user: user)
      RecipeList.create!(recipe: recipe,recipe_list: list)
      RecipeList.create!(recipe: other_recipe,recipe_list: list)

      expect(list.recipes).to include(recipe)
      expect(list.recipes).to include(other_recipe)
    end
  end
end



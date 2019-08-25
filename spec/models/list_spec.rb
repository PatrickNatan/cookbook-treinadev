require 'rails_helper'

RSpec.describe List, type: :model do
    describe "recipes belong to a list" do 
        it "list have many recipes" do
            #A--
            user = User.create!(email:"tst@email.com", password:"123456")
            recipe_type = RecipeType.create!(name: 'Sobremesa')
            
            recipe = Recipe.create!(title: 'Bolo de cenoura', recipe_type: recipe_type,
            cuisine: 'Brasileira', difficulty: 'Médio',
            cook_time: 60,
            ingredients: 'Farinha, açucar, cenoura',
            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
            user: user)

            other_recipe = Recipe.create!(title: 'Chocolate', recipe_type: recipe_type,
            cuisine: 'Brasileira', difficulty: 'Médio',
            cook_time: 60,
            ingredients: 'Farinha, açucar, cenoura',
            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
            user: user)

            list = List.create!(name: "doceria", user: user)
            RecipeList.create!(recipe: recipe,list: list)
            RecipeList.create!(recipe: other_recipe,list: list)
            #--A
            expect(list.recipes).to include(recipe)
            expect(list.recipes).to include(other_recipe)
        end
    end

end

require 'rails_helper'

describe "delete test" do
    it "try delete recipe no auth" do
        user = User.create!(email:"tst@email.com", password:"123456")
        recipe_type = RecipeType.create(name: 'Sobremesa')
        recipe = Recipe.create(title: 'Bolo', 
          recipe_type: recipe_type,
          cuisine: 'Brasileira', difficulty: 'Médio',
          cook_time: 60,
          ingredients: 'Farinha, açucar, cenoura',
          cook_method: 'Cozinhe a cenoura',
          user: user)
          
        delete recipe_path(recipe)
    
        expect(Recipe.count).to eq 1
    end
    it "try delete recipe auth" do
        user = User.create!(email:"tst@email.com", password:"123456")
        recipe_type = RecipeType.create(name: 'Sobremesa')
        recipe = Recipe.create(title: 'Bolo', 
          recipe_type: recipe_type,
          cuisine: 'Brasileira', difficulty: 'Médio',
          cook_time: 60,
          ingredients: 'Farinha, açucar, cenoura',
          cook_method: 'Cozinhe a cenoura',
          user: user)
          
        sign_in user
        delete recipe_path(recipe)
    
        expect(Recipe.count).to eq 0
    end

    it "try delete not owner recipe" do
        another_user = User.create!(email:"teste@email.com", password:"123456")
        
        user = User.create!(email:"tst@email.com", password:"123456")
       
        recipe_type = RecipeType.create(name: 'Sobremesa')
        recipe = Recipe.create(title: 'Bolo', 
          recipe_type: recipe_type,
          cuisine: 'Brasileira', difficulty: 'Médio',
          cook_time: 60,
          ingredients: 'Farinha, açucar, cenoura',
          cook_method: 'Cozinhe a cenoura',
          user: user)
          
        sign_in another_user
        delete recipe_path(recipe)
    
        expect(Recipe.count).to eq 1

    end
end
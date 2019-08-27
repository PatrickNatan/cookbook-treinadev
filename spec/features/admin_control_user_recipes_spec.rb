require 'rails_helper'
feature 'admin control user recipes' do
    scenario "successfully" do
        recipe_type = RecipeType.create(name: 'Sobremesa')
        user = User.create!(email:"abc@email.com", password:"123456")
        recipe = Recipe.create!(title: 'pudim', difficulty: 'Médio',
                      recipe_type: recipe_type, cuisine: 'Brasileira',
                      cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                      user: user)
        another_recipe = Recipe.create!(title: 'biscoito', difficulty: 'Médio',
        recipe_type: recipe_type, cuisine: 'Brasileira',
        cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
        cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
        user: user,status: 1)
        
        recipe.reload
        another_recipe.reload
    
        visit root_path
    
        expect(page).to have_content('biscoito')
        expect(page).not_to have_content('pudim')
    end
end


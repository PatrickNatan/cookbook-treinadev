require 'rails_helper'
feature 'admin control user recipes' do
    scenario "successfully" do
        #A--
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
        #-A-
        visit root_path
        #--A
        expect(page).to have_content('biscoito')
        expect(page).not_to have_content('pudim')
    end
    scenario "admin can accept or decline user recipes" do
        #A--
        admin = User.create!(email:"admin@email.com", password:"123456",admin: true)
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
                        user: user)
        recipe.reload
        another_recipe.reload
        #-A-
        visit root_path
        click_on 'Entrar'
        within("form") do
              fill_in 'Email', with: user.email
              fill_in 'Senha', with: '123456'
              click_on 'Entrar'
        end 
        click_on 'Controlar receitas'
        click_on "Aceitar #{recipe.title}"
        click_on "Rejeitar #{another_recipe.title}"
        visit root_path
        #--A
        expect(page).to have_content("#{recipe.title}")
        expect(page).not_to have_content("#{another_recipe.title}")
    end
end


require 'rails_helper'

feature 'user can add and remove recipe to recipe list' do
    scenario "successfully" do
        #A--
        user = User.create(email: 'teste@email.com', password: '123456')
        list=List.create!(name: 'Aniversario', user: user)
        recipe_type =RecipeType.create!(name: "Doces")
        recipe = Recipe.create!(
            title: 'Bolo',
            difficulty: 'Médio',
            recipe_type: recipe_type,
            cuisine: 'Brasileira',
            cook_time: 50, 
            ingredients:  'Farinha, açucar, cenoura',
            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
            user:user)
        #-A-
        visit root_path
        click_on 'Entrar'
        within("form") do
              fill_in 'Email', with: user.email
              fill_in 'Senha', with: '123456'
              click_on 'Entrar'
        end
        click_on recipe.title
        select 'Aniversario', from: 'Adicionar a lista:'
        click_on 'Adicionar'
        visit root_path
        click_on "Minhas Listas"
        click_on list.name
        #--A
        expect(page).to have_content('Bolo')
        expect(list.recipes.first.title).to include("Bolo")
    end
    scenario "cant add to list two equal recipes" do 
           #A--
           user = User.create(email: 'teste@email.com', password: '123456')
           list=List.create!(name: 'Aniversario', user: user)
           recipe_type =RecipeType.create!(name: "Doces")
           recipe = Recipe.create!(
               title: 'Bolo',
               difficulty: 'Médio',
               recipe_type: recipe_type,
               cuisine: 'Brasileira',
               cook_time: 50, 
               ingredients:  'Farinha, açucar, cenoura',
               cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
               user:user)
           recipe_list = RecipeList.create!(recipe: recipe,list: list)
           #-A-
           visit root_path
           click_on 'Entrar'
           within("form") do
                 fill_in 'Email', with: user.email
                 fill_in 'Senha', with: '123456'
                 click_on 'Entrar'
           end
           click_on recipe.title
           select 'Aniversario', from: 'Adicionar a lista:'
           click_on 'Adicionar'
           #--A
           expect(page).to have_content('Essa receita já foi adicionada a essa lista')
    end
    scenario "can remove recipe of recipe list" do
        #A--
        user = User.create(email: 'teste@email.com', password: '123456')
        list=List.create!(name: 'Aniversario', user: user)
        recipe_type =RecipeType.create!(name: "Doces")
        recipe = Recipe.create!(
            title: 'Bolo',
            difficulty: 'Médio',
            recipe_type: recipe_type,
            cuisine: 'Brasileira',
            cook_time: 50, 
            ingredients:  'Farinha, açucar, cenoura',
            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
            user:user)
        recipe_list = RecipeList.create!(recipe: recipe,list: list)
        #-A-
        visit root_path
        click_on 'Entrar'
        within("form") do
              fill_in 'Email', with: user.email
              fill_in 'Senha', with: '123456'
              click_on 'Entrar'
        end
        click_on "Minhas Listas"
        click_on list.name
        click_on "Remover #{recipe.title}"
        #--A
        expect(page).not_to have_content("Bolo")
        expect(list.recipes.first.title).not_to include("Bolo")
    end
end

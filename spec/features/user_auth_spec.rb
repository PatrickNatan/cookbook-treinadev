require 'rails_helper'

feature 'User' do
    scenario 'successfully' do
    #A--
    usr = User.create!(email: 'tst@email.com', password: '123456')
    #-A-
    visit root_path
    click_on 'Entrar'
    within('form') do
        fill_in 'Email', with: usr.email
        fill_in 'Senha', with: '123456'
        click_on 'Entrar'
      end
    #--A
    expect(current_path).to eq root_path
    expect(page).to have_content(usr.email)
    expect(page).to have_link('Sair')
    expect(page).not_to have_link('Entrar')
    end

    scenario 'log out' do
      #A--
      usr = User.create!(email:"tst@email.com", password:"123456")
      #-A-
      visit root_path
      click_on 'Entrar'
      within("form") do
        fill_in 'Email', with: usr.email
        fill_in 'Senha', with: '123456'
        click_on 'Entrar'
      end
      click_on 'Sair'
      #--A
      expect(page).to have_link('Entrar')
      expect(page).not_to have_link('Sair')
      expect(page).not_to have_content(usr.email)
    end
    #Usuario não autenticado não pode acessar as rotas pre-definidas abaixo e nem ver os botões
    scenario 'no auth cant use create route ' do
      #-A-
      visit new_recipe_path
      #--A
      expect(current_path).to eq new_user_session_path
    end

    scenario 'no auth cant see create button ' do
      #-A-
      visit root_path
      #--A
      expect(page).not_to have_content('Enviar uma receita')
    end
    
    scenario 'no auth cant see edit button ' do
      #A--
      user = User.create!(email:"tst@email.com", password:"123456")
      recipe_type = RecipeType.create(name: 'Sobremesa')
      recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                             cuisine: 'Brasileira', difficulty: 'Médio',
                             cook_time: 60,
                             ingredients: 'Farinha, açucar, cenoura',
                             cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                             user: user)
      #-A-
      visit root_path
      click_on recipe.title
      #--A
      expect(page).not_to have_content('Editar')
    end

    scenario 'no auth cant acess edit route ' do
      #A--
      user = User.create!(email:"tst@email.com", password:"123456")
      recipe_type = RecipeType.create(name: 'Sobremesa')
      recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                             cuisine: 'Brasileira', difficulty: 'Médio',
                             cook_time: 60,
                             ingredients: 'Farinha, açucar, cenoura',
                             cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                             user: user)
      #-A-
      visit edit_recipe_path(recipe)
      #--A
      expect(current_path).to eq new_user_session_path
    end

    scenario 'no auth cant se my_recipes button' do
      #-A-
      visit root_path
      #--A
      expect(page).not_to have_content('Minhas receitas')
    end

    scenario 'no auth cant acess my_recipes route' do
      #-A-
      visit my_recipes_path
      #--A
      expect(current_path).to eq new_user_session_path
    end
  
end

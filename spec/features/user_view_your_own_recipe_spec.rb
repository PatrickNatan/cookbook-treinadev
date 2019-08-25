require 'rails_helper'
feature 'User view your own recipes' do
  scenario 'successfully' do
    #A--
    user = User.create!(email:"teste1@email.com", password:"123456")
    userT = User.create!(email:"teste@email.com", password:"987654")
    recipe_type = RecipeType.create(name: 'Entrada')
    Recipe.create!(title: 'Bolo de Cafe ', difficulty: 'Médio',
    recipe_type: recipe_type, cuisine: 'Brasileira',
    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
    user: userT)
    Recipe.create!(title: 'Bolo de chocolate', difficulty: 'Médio',
    recipe_type: recipe_type, cuisine: 'Brasileira',
    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
    user: user)
    Recipe.create!(title: 'Bolo de cenoura', difficulty: 'Médio',
    recipe_type: recipe_type, cuisine: 'Brasileira',
    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
    user: user)
    #-A-
    visit root_path
    click_on 'Entrar'
    within("form") do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Minhas receitas'
    #--A
    expect(page).to have_css('h1', text: 'Bolo de chocolate')
    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).not_to have_content('Bolo de Cafe')
    click_on 'Voltar'
  end

  scenario "show if user click in button and have any recipes in index" do
    #A--
    user = User.create!(email:"tst@email.com", password:"123456")
    #-A-
    visit root_path
    click_on 'Entrar'
    within("form") do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Minhas receitas'
    #--A
    expect(page).to have_content('Você não tem receitas cadastradas')
    expect(current_path).not_to eq my_recipes_path
  end

end
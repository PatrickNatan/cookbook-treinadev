require 'rails_helper'

feature 'User search recipe' do
  scenario 'sucessfully' do
    #
    user = User.create!(email: 'tst@email.com', password: '123456')
    recipe_type=RecipeType.create(name: 'Sobremesa')
    Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',user: user)
    Recipe.create(title: 'Pudim', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',user: user)
    #
    visit root_path
    fill_in 'Buscar', with: 'Bolo de cenoura'
    click_on 'Pesquisar uma receita'
    #
    expect(page).to have_css('li', text: 'Bolo de cenoura')
    expect(page).not_to have_content("Pudim")
  end

  scenario 'and search for a recipe by exactly name and dont find' do
    recipe_type=RecipeType.create(name: 'Sobremesa')
    user = User.create!(email: 'tst@email.com', password: '123456')
    Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',user: user)
    Recipe.create(title: 'Pudim', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',user: user)
    #A
    visit root_path
    fill_in 'Buscar', with: 'Banana'
    click_on 'Pesquisar uma receita'
    #A
    expect(page).to have_content('Não foi possível encontrar a receita')
  end
  scenario "and show similiar" do
    user = User.create!(email: 'tst@email.com', password: '123456')
    recipe_type=RecipeType.create(name: 'Sobremesa')
    Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',user:user)
    Recipe.create(title: 'Bolo de manga', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',user:user)
    Recipe.create(title: 'Pudim', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    #A
    visit root_path
    fill_in 'Buscar', with: 'Bolo'
    click_on 'Pesquisar uma receita'
    #A
    expect(page).to have_css('li', text: 'Bolo de cenoura')
    expect(page).to have_css('li', text: 'Bolo de manga')
    expect(page).not_to have_content("Pudim")
  end
end

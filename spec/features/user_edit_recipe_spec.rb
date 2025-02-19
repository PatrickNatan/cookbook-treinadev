require 'rails_helper'

feature 'User update recipe' do
  scenario 'successfully' do
    user = User.create!(email: 'tst@email.com', password: '123456')
    recipe_type = RecipeType.create!(name: "Entrada")
    RecipeType.create(name: 'Entrada')
    Recipe.create(title: 'Bolodecenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: 'Brasileira',
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',user: user,status: "accepted")
    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'
    within("form") do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Bolodecenoura'
    click_on 'Editar'

    fill_in 'Título', with: 'Bolo de cenoura'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Médio'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Cenoura, farinha, ovo, oleo de soja e chocolate'
    fill_in 'Como Preparar', with: 'Faça um bolo e uma cobertura de chocolate'

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Médio')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('p', text:  'Cenoura, farinha, ovo, oleo de soja e chocolate')
    expect(page).to have_css('p', text: 'Faça um bolo e uma cobertura de chocolate')
  end

  scenario 'and must fill in all fields' do
    user = User.create!(email: 'tst@email.com', password: '123456')
    recipe_type = RecipeType.create!(name: "Entrada")
    Recipe.create(title: 'Bolodecenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: 'Brasileira',
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',user: user,status: "accepted")

    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'
    within("form") do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Bolodecenoura'
    click_on 'Editar'

    fill_in 'Título', with: ''
    fill_in 'Cozinha', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível salvar a receita')
  end
   #Autenticação de rota e de mostra botão
  scenario "user is not recipe author see edit button" do
    #A--
    recipe_type = RecipeType.create!(name: "Entrada")
    user = User.create!(email: 'tst@teste.com', password: '123456')
    userT = User.create!(email: 'teste@teste.com', password: '123456')
    recipe = Recipe.create!(title: 'Bolo',
      difficulty: 'Médio',
      recipe_type: recipe_type,
      cuisine: 'Brasileira',
      cook_time: 50, 
      ingredients:  'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user:user,status: "accepted")
    #-A-
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'Email', with: userT.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end  
    click_on "Bolo"
    #--A
    expect(page).not_to have_content('Editar')
  end
 
  scenario "user cannot edit another user's recipe by route" do
    #A--
    recipe_type = RecipeType.create!(name: "Entrada")
    user = User.create!(email: 'tst@teste.com', password: '123456')
    userT = User.create!(email: 'teste@teste.com', password: '123456')
    recipe = Recipe.create!(title: 'Bolo',
      difficulty: 'Médio',
      recipe_type: recipe_type,
      cuisine: 'Brasileira',
      cook_time: 50, 
      ingredients:  'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user:user,status: "accepted")
    #-A-
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'Email', with: userT.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end  
    visit edit_recipe_path(recipe)
    #--A
    expect(current_path).to eq root_path
  end
end

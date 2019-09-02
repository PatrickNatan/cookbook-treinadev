require 'rails_helper'
describe "API Recipe" do
  it "create recipe" do
    user = User.create!(email:"tst@email.com", password:"123456")
    recipe_type = RecipeType.create(name: 'Sobremesa')
    post '/api/v1/recipes', params: {recipe: 
        { title: 'Bolo', 
          recipe_type_id: recipe_type.id ,
          cuisine: 'Br', 
          difficulty: 'Médio', 
          cook_time: 60,
          ingredients: 'Farinha', 
          cook_method: 'Cozinhe',
          user_id: user.id }  }

    expect(response).to have_http_status(:created)
    expect(response.body).to include('Bolo')
    expect(Recipe.count).to eq 1
  end
  it "recipe not created" do
    user = User.create!(email:"tst@email.com", password:"123456")
    recipe_type = RecipeType.create(name: 'Sobremesa')

    post '/api/v1/recipes', params: {recipe: 
        { title: '', 
          recipe_type_id: recipe_type.id ,
          cuisine: 'Br', 
          difficulty: 'Médio', 
          cook_time: 60,
          ingredients: 'Farinha', 
          cook_method: 'Cozinhe',
          user_id: user.id }  }

    expect(response).to have_http_status(412)
    expect(response.body).to include('Título não pode ficar em branco')
    expect(Recipe.count).to eq 0
  end

  it 'delete recipe' do
    user = User.create!(email:"tst@email.com", password:"123456")
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo', 
      recipe_type: recipe_type,
      cuisine: 'Brasileira', difficulty: 'Médio',
      cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura',
      user: user)
    
    delete "/api/v1/recipes/#{recipe.id}"
    
    expect(response).to have_http_status(204)
    expect(Recipe.count).to eq 0
  end

  it 'delete recipe' do
    delete "/api/v1/recipes/000"
    
    expect(response).to have_http_status(404)
  end

  it 'accept recipe' do
    user = User.create!(email:"tst@email.com", password:"123456")
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo', 
        recipe_type: recipe_type,
        cuisine: 'Brasileira', difficulty: 'Médio',
        cook_time: 60,
        ingredients: 'Farinha, açucar, cenoura',
        cook_method: 'Cozinhe a cenoura',
        user: user)
    
    post "/api/v1/recipes/#{recipe.id}/accepted"
    
    expect(response).to have_http_status(200)
    expect(response.body).to include('accepted')
    expect(response.body).to include('Bolo')

  end

  it 'decline recipe' do
    user = User.create!(email:"tst@email.com", password:"123456")
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo', 
        recipe_type: recipe_type,
        cuisine: 'Brasileira', difficulty: 'Médio',
        cook_time: 60,
        ingredients: 'Farinha, açucar, cenoura',
        cook_method: 'Cozinhe a cenoura',
        user: user)
    
    post "/api/v1/recipes/#{recipe.id}/declined"
    
    expect(response).to have_http_status(200)
    expect(response.body).to include('declined')
    expect(response.body).to include('Bolo')
  end


  it 'do not accept accepted recipe' do
    user = User.create!(email:"abc@email.com", password:"123456")
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    recipe = Recipe.create!(title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: 'Brasileira', difficulty: 'Médio',
      cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user: user,status: :accepted)
    #
    post "/api/v1/recipes/#{recipe.id}/accepted"
    #
    expect(response).to have_http_status(200)
  end

  it 'decline declined recipe' do
    user = User.create!(email:"tst@email.com", password:"123456")
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create!(title: 'Bolo de cenoura', recipe_type: recipe_type,
        cuisine: 'Brasileira', difficulty: 'Médio',
        cook_time: 60,
        ingredients: 'Farinha, açucar, cenoura',
        cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
        user: user,status: :accepted)
    #
    post "/api/v1/recipes/#{recipe.id}/declined"
    #
    expect(response).to have_http_status(200)
  end

  it 'no recipes to accept' do  
    post '/api/v1/recipes/0/accepted'
    expect(response.status).to eq 404
  end

  it 'no recipes to reject' do  
    post '/api/v1/recipes/0/declined'
    expect(response.status).to eq 404
  end
end

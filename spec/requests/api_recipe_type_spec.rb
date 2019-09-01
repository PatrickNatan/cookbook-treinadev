require 'rails_helper'
describe "API Recipe Type" do
  it "create a recipe type" do
    post "/api/v1/recipe_types", params: { recipe_type: { name:  "Sobremesa" } }
    
    expect(response).to have_http_status(:created)
    expect(RecipeType.count).to eq 1
  end
  it "create recipe with nill name" do
    
    post "/api/v1/recipe_types", params: { recipe_type: { name:  "" } }
    
    expect(response).to have_http_status(406)
    expect(response.body).to include('Tipo de receita não pode conter campos vazios')
  end

  it 'recipe by recipe type' do
    user = User.create!(email:"abc@email.com", password:"123456")
    recipe_type = RecipeType.create(name: 'Sobremesa')
    another_recipe_type = RecipeType.create(name: 'Bebidas')
    recipe = Recipe.create(title: 'Bolo de cenoura', 
      recipe_type: recipe_type,
      cuisine: 'Brasileira', difficulty: 'Médio',
      cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user: user)
    other_recipe = Recipe.create(title: 'Sorvete', 
      recipe_type: recipe_type,
      cuisine: 'Brasileira', difficulty: 'Médio',
      cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user: user)
    another_recipe = Recipe.create(title: 'Suco', 
      recipe_type: another_recipe_type,
      cuisine: 'Brasileira', difficulty: 'Médio',
      cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user: user)

      get "/api/v1/recipe_types/#{recipe_type.id}"

      expect(response.status).to eq 200
      expect(response.body).to include(recipe_type.name)
      expect(response.body).to include(recipe.title)
      expect(response.body).to include(other_recipe.title)
      expect(response.body).not_to include(another_recipe.title)
  end
       
    it 'recipes from a type not found'do
        
     get "/api/v1/recipe_types/000"

     expect(response.status).to eq 404
     expect(response.body).to include('Não encontrado')

    end
end

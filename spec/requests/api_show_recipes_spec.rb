require 'rails_helper'
describe "API show Recipe" do
    it "send recipe details" do
        #A--
        user = User.create!(email:"tst@email.com", password:"123456")
        recipe_type = RecipeType.create(name: 'Sobremesa')
        recipe = Recipe.create(title: 'Bolo de cenoura', 
                                recipe_type: recipe_type,
                                cuisine: 'Brasileira', difficulty: 'Médio',
                                cook_time: 60,
                                ingredients: 'Farinha, açucar, cenoura',
                                cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                                user: user)
        #-A-
        get  "/api/v1/recipes/#{recipe.id}"
        #--A
        expect(response.status).to eq 200
        expect(response.body).to include(recipe.title)
    end

    it 'dont find recipe' do

        get  '/api/v1/recipes/0'

        expect(response.status).to eq 404
        expect(response.body).to include('Não encontrado')
    end

    it 'show all recipes' do
        user = User.create!(email:"tst@email.com", password:"123456")
        recipe_type = RecipeType.create(name: 'Sobremesa')
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
          recipe_type: recipe_type,
          cuisine: 'Brasileira', difficulty: 'Médio',
          cook_time: 60,
          ingredients: 'Farinha, açucar, cenoura',
          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
          user: user)
        
        get '/api/v1/recipes/'
    
        expect(response.status).to eq 200
        expect(response.body).to include(recipe.title)
        expect(response.body).to include(other_recipe.title)
        expect(response.body).to include(another_recipe.title)
      end

      it 'show all accepted recipes' do
        #
        user = User.create!(email:"tst@email.com", password:"123456")
        recipe_type = RecipeType.create(name: 'Sobremesa')
        recipe = Recipe.create(title: 'Bolo de cenoura', 
          recipe_type: recipe_type,
          cuisine: 'Brasileira', difficulty: 'Médio',
          cook_time: 60,
          ingredients: 'Farinha, açucar, cenoura',
          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
          user: user, status: :accepted)
        other_recipe = Recipe.create(title: 'Sorvete',
          recipe_type: recipe_type,
          cuisine: 'Brasileira', difficulty: 'Médio',
          cook_time: 60,
          ingredients: 'Farinha, açucar, cenoura',
          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
          user: user, status: :accepted)
        another_recipe = Recipe.create(title: 'Suco', 
          recipe_type: recipe_type,
          cuisine: 'Brasileira', difficulty: 'Médio',
          cook_time: 60,
          ingredients: 'Farinha, açucar, cenoura',
          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
          user: user, status: :declined)

        get '/api/v1/recipes?status=accepted'
        
        expect(response.status).to eq 200
        expect(response.body).to include(recipe.title)
        expect(response.body).to include(other_recipe.title)
        expect(response.body).not_to include(another_recipe.title)
       end

       it 'show all declined recipes' do
        #
        user = User.create!(email:"tst@email.com", password:"123456")
        recipe_type = RecipeType.create(name: 'Sobremesa')
        recipe = Recipe.create(title: 'Bolo de cenoura', 
          recipe_type: recipe_type,
          cuisine: 'Brasileira', difficulty: 'Médio',
          cook_time: 60,
          ingredients: 'Farinha, açucar, cenoura',
          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
          user: user, status: :declined)
        other_recipe = Recipe.create(title: 'Sorvete',
          recipe_type: recipe_type,
          cuisine: 'Brasileira', difficulty: 'Médio',
          cook_time: 60,
          ingredients: 'Farinha, açucar, cenoura',
          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
          user: user, status: :declined)
        another_recipe = Recipe.create(title: 'Suco', 
          recipe_type: recipe_type,
          cuisine: 'Brasileira', difficulty: 'Médio',
          cook_time: 60,
          ingredients: 'Farinha, açucar, cenoura',
          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
          user: user, status: :accepted)

        get '/api/v1/recipes?status=declined'
        
        expect(response.status).to eq 200
        expect(response.body).to include(recipe.title)
        expect(response.body).to include(other_recipe.title)
        expect(response.body).not_to include(another_recipe.title)
       end

       it 'show all pending recipes' do
        #
        user = User.create!(email:"tst@email.com", password:"123456")
        recipe_type = RecipeType.create(name: 'Sobremesa')
        recipe = Recipe.create(title: 'Bolo de cenoura', 
          recipe_type: recipe_type,
          cuisine: 'Brasileira', difficulty: 'Médio',
          cook_time: 60,
          ingredients: 'Farinha, açucar, cenoura',
          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
          user: user, status: :pending)
        other_recipe = Recipe.create(title: 'Sorvete',
          recipe_type: recipe_type,
          cuisine: 'Brasileira', difficulty: 'Médio',
          cook_time: 60,
          ingredients: 'Farinha, açucar, cenoura',
          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
          user: user, status: :declined)
        another_recipe = Recipe.create(title: 'Suco', 
          recipe_type: recipe_type,
          cuisine: 'Brasileira', difficulty: 'Médio',
          cook_time: 60,
          ingredients: 'Farinha, açucar, cenoura',
          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
          user: user, status: :accepted)

        get '/api/v1/recipes?status=pending'
        
        expect(response.status).to eq 200
        expect(response.body).to include(recipe.title)
        expect(response.body).not_to include(other_recipe.title)
        expect(response.body).not_to include(another_recipe.title)
       end

       it 'params invalid' do
        #
        user = User.create!(email:"tst@email.com", password:"123456")
        recipe_type = RecipeType.create(name: 'Sobremesa')
        recipe = Recipe.create(title: 'Bolo de cenoura', 
          recipe_type: recipe_type,
          cuisine: 'Brasileira', difficulty: 'Médio',
          cook_time: 60,
          ingredients: 'Farinha, açucar, cenoura',
          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
          user: user, status: :pending)

        get '/api/v1/recipes?status=nonexiste'
        
        expect(response.status).to eq 404
        expect(response.body).not_to include(recipe.title)
       end
end
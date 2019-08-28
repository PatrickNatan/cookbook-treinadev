require 'rails_helper'

describe "API TEST" do
    it 'return json' do
            #A--
            user = User.create!(email:"tst@email.com", password:"123456")
            recipe_type = RecipeType.create(name: 'Sobremesa')
            recipe = Recipe.create(title: 'Bolo', 
                recipe_type: recipe_type,
                cuisine: 'Brasileira', difficulty: 'Médio',
                cook_time: 60,
                ingredients: 'Farinha, açucar, cenoura',
                cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                user: user)
            #-A-
            get "/api/v1/recipes/#{recipe.id}"
            #--A
            expect(response).to have_http_status(:ok)
            expect(response.body).to include(recipe.title)
    end
end

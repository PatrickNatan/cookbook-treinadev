require 'rails_helper'

RSpec.describe User, type: :model do
    describe "#recipe_owner?" do 
        it "true" do
          user = User.create!(email:"tst@email.com", password:"123456")
          recipe_type = RecipeType.create(name: 'Sobremesa')
          recipe = Recipe.create(title: 'Bolo', 
          recipe_type: recipe_type,
          cuisine: 'Brasileira', difficulty: 'Médio',
          cook_time: 60,
          ingredients: 'Farinha, açucar, cenoura',
          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
          user: user)
          expect(user.recipe_owner?(recipe)).to eq(true)
        end
    
        it 'false'do
          user = User.create!(email:"tst@email.com", password:"123456")
          userT = User.create!(email:"teste@email.com", password:"123456")
          recipe_type = RecipeType.create(name: 'Sobremesa')
          recipe = Recipe.create(title: 'Bolo',
          recipe_type: recipe_type,
          cuisine: 'Brasileira', difficulty: 'Médio',
          cook_time: 60,
          ingredients: 'Farinha, açucar, cenoura',
          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
          user: userT)
    
          expect(user.recipe_owner?(recipe)).to eq(false)
        end

        it "nil" do 
          user = User.create!(email:"tst@email.com", password:"123456")
          expect(user.recipe_owner?(nil)).to eq(false)
        end
        
      end
end


require 'rails_helper'

feature 'Admin register recipe type' do
        scenario 'successfully' do

            visit root_path

            click_on 'Criar tipo de receita'
            fill_in 'Tipo de receita', with: 'Entrada'
            click_on 'Enviar'

            expect(page).to have_css('h1', text: 'Entrada')
        end

        scenario 'and must fill in all fields' do
            
            visit root_path

            click_on 'Criar tipo de receita'
            fill_in 'Tipo de receita', with: ''
            click_on 'Enviar'

            expect(page).to have_content('Tipo de receita não pode conter campos vazios')
        end

        scenario 'and not have duplicate name' do
            recipe_type = RecipeType.create(name: 'Entrada')

            visit root_path
            click_on 'Criar tipo de receita'
            fill_in 'Tipo de receita', with: 'Entrada'
            click_on 'Enviar'

            expect(page).to have_content('Tipo de receita já existente')
        end
end

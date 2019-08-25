require 'rails_helper'

feature 'user create recipe list' do
    scenario "successfully" do
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
      click_on 'Minhas Listas'
      click_on 'Adicionar lista de receitas'
      fill_in 'Nome da lista', with: 'Sabado'
      click_on 'Criar'
      #--A
      expect(page).to have_content('Sabado')
    end
    scenario "user cant create a empty list" do
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
      click_on 'Minhas Listas'
      click_on 'Adicionar lista de receitas'
      fill_in 'Nome da lista', with: ''
      click_on 'Criar'
      #--A
      expect(page).to have_content('Você não pode criar listas sem nome')
    end

    scenario "show all lists of user" do
      #A--
      user = User.create!(email:"teste1@email.com", password:"123456")
      another_user=User.create!(email:"teste2@email.com", password:"123456")

      list= List.create!(name: "Lanches",user: user)
      list2=  List.create!(name: "Sucos",user: user)
      another_list= List.create!(name: "Jantas",user:another_user)
      #-A-
      visit root_path
      click_on 'Entrar'
      within("form") do
            fill_in 'Email', with: user.email
            fill_in 'Senha', with: '123456'
            click_on 'Entrar'
      end
      click_on 'Minhas Listas'
      #--A
      expect(page).to have_content(list.name)
      expect(page).to have_content(list2.name)
      expect(page).not_to have_content(another_list.name)
    end

    scenario "user cant create two list with same name" do
      #A--
      user = User.create!(email:"teste1@email.com", password:"123456")
      List.create!(name: "Lanches",user: user)
      #-A-
      visit root_path
      click_on 'Entrar'
      within("form") do
            fill_in 'Email', with: user.email
            fill_in 'Senha', with: '123456'
            click_on 'Entrar'
      end
      click_on 'Minhas Listas'
      click_on 'Adicionar lista de receitas'
      fill_in 'Nome da lista', with: 'Lanches'
      click_on 'Criar'
      #--A
      expect(page).to have_content('Você não pode criar duas listas com nomes iguais')
    end

    scenario "user can create lists with same name as another user list" do
      #A--
      user = User.create!(email:"teste1@email.com", password:"123456")
      another_user = User.create!(email:"teste2@email.com", password:"123456")
      List.create!(name: "Lanches",user: another_user)
      #-A-
      visit root_path
      click_on 'Entrar'
      within("form") do
            fill_in 'Email', with: user.email
            fill_in 'Senha', with: '123456'
            click_on 'Entrar'
      end
      click_on 'Minhas Listas'
      click_on 'Adicionar lista de receitas'
      fill_in 'Nome da lista', with: 'Lanches'
      click_on 'Criar'
      #--A
      expect(page).to_not have_content('Você não pode criar duas listas com nomes iguais')
    end
end



require 'rails_helper'

feature 'Admin register recipe type' do
    
    scenario 'successfully' do
    #A--
    usr = User.create!(email: 'tst@email.com', password: '123456')
    #-A-
    visit root_path
    click_on 'Entrar'
    within('form') do
        fill_in 'Email', with: usr.email
        fill_in 'Senha', with: '123456'
        click_on 'Entrar'
      end
    #--A
    expect(current_path).to eq root_path
    expect(page).to have_content(usr.email)
    expect(page).to have_link('Sair')
    expect(page).not_to have_link('Entrar')
    end

    scenario 'log out' do
      #A--
      usr = User.create!(email:"tst@email.com", password:"123456")
      #-A-
      visit root_path
      click_on 'Entrar'
      within("form") do
        fill_in 'Email', with: usr.email
        fill_in 'Senha', with: '123456'
        click_on 'Entrar'
      end
      click_on 'Sair'
      #--A
      expect(page).to have_link('Entrar')
      expect(page).not_to have_link('Sair')
      expect(page).not_to have_content(usr.email)
 end

end
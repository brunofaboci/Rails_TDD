require 'rails_helper'

RSpec.feature "Customers", type: :feature do
  scenario 'Verificar link cadastro de clientes' do
    visit(root_path)
    expect(page).to have_link('Cadastro de Clientes')
  end

  scenario 'verificar pagina cadastro de clientes' do
    visit(root_path)
    click_on('Cadastro de Clientes')
    expect(page).to have_content('Clientes')
    expect(page).to have_link('Novo Cliente')
  end

  scenario 'Verifica page Novo Cliente' do
    visit(customers_path)
    click_on('Novo Cliente')
    expect(page).to have_content('Novo Cliente')
  end

  scenario 'Cadastra um cliente valido' do
    visit(new_customer_path)
    customer_first_name = Faker::Name.first_name

    fill_in('First name', with: customer_first_name)
    fill_in('Last name', with: Faker::Name.last_name)
    fill_in('Email', with: Faker::Internet.email)
    fill_in('Phone', with: Faker::PhoneNumber.phone_number)
    attach_file('Avatar', "#{Rails.root}/spec/fixtures/batman.jpg")
    choose(option: ['S', 'N'].sample)
    click_on('Criar')

    expect(page).to have_content('Cliente cadastrado com sucesso')
    expect(Customer.last.first_name).to eq(customer_first_name)
  end
end
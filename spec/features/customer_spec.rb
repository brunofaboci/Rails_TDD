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

  scenario 'Cadastra um cliente valido - Create' do
    # Happy Path -- quando o usuario se comporta da maneira esperada
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

  scenario 'Cadastro de cliente invalido' do
    # Sad Path -- quando o usuario não se comporta da maneira esperada
    visit(new_customer_path)

    click_on('Criar')

    expect(page).to have_content("can't be blank")
  end

  scenario 'Exibir Cliente - Show' do
    customer = Customer.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      smoker: ['S', 'N'].sample,
      avatar: "#{Rails.root}/spec/fixtures/batman.jpg"
    )
    visit(customer_path(customer.id))

    expect(page).to have_content(customer.first_name)
  end

  scenario 'Testando Index' do
    customer1 = Customer.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      smoker: ['S', 'N'].sample,
      avatar: "#{Rails.root}/spec/fixtures/batman.jpg"
    )

    customer2 = Customer.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      smoker: ['S', 'N'].sample,
      avatar: "#{Rails.root}/spec/fixtures/batman.jpg"
    )

    customer3 = Customer.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      smoker: ['S', 'N'].sample,
      avatar: "#{Rails.root}/spec/fixtures/batman.jpg"
    )
    visit(customers_path)

    expect(page).to have_content(customer1.first_name).and have_content(customer2.first_name).and have_content(customer3.first_name)
  end

  scenario 'Atualizar um cliente - Update' do
    customer = Customer.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      smoker: ['S', 'N'].sample,
      avatar: "#{Rails.root}/spec/fixtures/batman.jpg"
    )

    new_name = Faker::Name.first_name
    visit(edit_customer_path(customer.id))
    fill_in('First name', with: new_name)
    click_on('Salvar')

    expect(page).to have_content('Cliente atualizado com sucesso')
    expect(page).to have_content(new_name)

  end

  scenario 'Clicla no link SHOW' do
    customer = Customer.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      smoker: ['S', 'N'].sample,
      avatar: "#{Rails.root}/spec/fixtures/batman.jpg"
    )

    visit(customers_path)
    find(:xpath, "/html/body/table/tbody/tr[1]/td[4]/a").click

    expect(page).to have_content('Show')  
  end

  scenario 'Clicla no link EDIT' do
    customer = Customer.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      smoker: ['S', 'N'].sample,
      avatar: "#{Rails.root}/spec/fixtures/batman.jpg"
    )

    visit(customers_path)
    find(:xpath, "/html/body/table/tbody/tr[1]/td[5]/a").click

    expect(page).to have_content('Editar')  
  end

end
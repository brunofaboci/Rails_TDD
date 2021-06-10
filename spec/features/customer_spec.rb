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

end

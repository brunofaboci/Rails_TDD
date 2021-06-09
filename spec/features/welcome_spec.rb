require 'rails_helper'

RSpec.feature "Welcomes", type: :feature do
  scenario 'Mostrar Boas Vindas' do
    visit(root_path)
    expect(page).to have_content('Welcome')
  end

  scenario 'Virificar link p/ cadastro clientes' do
    visit(root_path)
    expect(find('ul li')).to have_link('Cadastro de Clientes')  
  end
end

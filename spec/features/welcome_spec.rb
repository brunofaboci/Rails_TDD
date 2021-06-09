require 'rails_helper'

RSpec.feature "Welcomes", type: :feature do
  scenario 'Mostrar Boas Vindas' do
    visit('/')
    expect(page).to have_content('Welcome')
  end
end

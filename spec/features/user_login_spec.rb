require 'rails_helper'

RSpec.feature 'User Login', type: :feature do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
  end

  scenario 'User logs in with valid credentials' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content('Oops!! There are no categories')
    expect(current_path).to eq(categories_path)
  end

  scenario 'User fails to log in with invalid credentials' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'invalid_password'
    click_button 'Log in'

    # expect(page).to have_cnontent('Invalid Email or password')
    expect(current_path).to eq(new_user_session_path)
  end
end

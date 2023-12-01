require 'rails_helper'

RSpec.describe 'Categories management', type: :feature do
  let(:user) { create(:user) }
  let!(:category) { create(:category, user:) }

  before do
    login_as(user, scope: :user)
    visit categories_path
  end

  it 'displays a message when there are no categories' do
    Category.destroy_all # Clear all categories

    visit categories_path
    expect(page).to have_content('Oops!! There are no categories')
    expect(page).to have_link('Add a Category', href: new_categories_path)
  end

  it 'displays categories when they exist' do
    expect(page).to have_content('Welcome to the App!')
    expect(page).to have_css('.categories_list_container')

    within '.category_page' do
      expect(page).to have_link(category.name, href: category_purchases_path(category))
      expect(page).to have_content("Budget: #{category.purchases.sum(:amount)}$")
    end
  end

  it 'allows adding a new category' do
    click_link 'Add a Category'
    expect(page).to have_current_path(new_categories_path)
  end
end

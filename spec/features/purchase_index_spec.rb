require 'rails_helper'

RSpec.describe 'Purchases Index Page', type: :feature do
  context 'when the purchases list is not empty for a specific category' do
    let(:user) { FactoryBot.create(:user, :with_categories_and_purchases) }
    let(:category) { user.categories.first }

    before do
      login_as(user, scope: :user)
      visit category_purchases_path(category)
      # Logic to create a non-empty list of purchases for the category
      # You may need to adjust this logic based on how purchases are created
      # Perhaps something like `category.purchases.create(name: 'Sample Purchase', amount: 10.0)` within a loop
    end

    it 'displays the list of transactions' do
      expect(page).to have_css('.purchase_list_container')
      expect(page).to have_css('.purchase-box')
      expect(page).to have_content('Find your Transactions here')

      category.purchases.each do |purchase|
        expect(page).to have_content(purchase.updated_at.strftime('%e %b %Y'))
      end
    end
  end
end

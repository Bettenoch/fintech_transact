require 'rails_helper'

RSpec.describe 'Purchases Index Page', type: :feature do
  context 'when the purchases list is not empty for a specific category' do
    before do
      @user_with_categories_and_purchases = FactoryBot.create(:user_with_categories_and_purchases)
      @category = @user_with_categories_and_purchases.categories.first
      login_as(@user_with_categories_and_purchases, scope: :user)
      visit category_purchases_path(@category)
      # Logic to create a non-empty list of purchases for the category
    end

    it 'displays the list of transactions' do
      expect(page).to have_css('.purchase_list_container')
      expect(page).to have_css('.purchase-box')
      expect(page).to have_content('Find your Transactions here')

      @category.purchases.each do |purchase|
        expect(page).to have_content(purchase.updated_at.strftime('%e %b %Y'))
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Category, type: :model do
    describe 'validations' do
        it 'should be valid with valid credentials' do
            category = FactoryBot.create(:category)
            expect(category).to be_valid
        end

        it 'is not valid without a name' do
            category = Category.new(name: nil)
            expect(category).to_not be_valid
        end

        it 'is not valid without an icon' do
            category = Category.new(icon: nil)
            expect(category).to_not be_valid
        end
    end

    context "associations" do
      it "should destroy associated category_purchases" do
        category = FactoryBot.create(:category)
        FactoryBot.create_list(:category_purchase, 3, category: category)
  
        expect { category.destroy }.to change { CategoryPurchase.count }.by(-3)
      end
  
      it "should destroy associated purchases through category_purchases" do
        category = FactoryBot.create(:category)
        purchases = FactoryBot.create_list(:purchase, 3)
        purchases.each { |purchase| FactoryBot.create(:category_purchase, category: category, purchase: purchase) }
  
        expect { category.destroy }.to change { Purchase.count }.by(0) # Ensure purchases aren't destroyed
      end
    end
end
require 'rails_helper'

RSpec.describe Purchase, type: :model do
    describe 'validations' do
        it 'should be valid with valid credentials' do
            purchase = FactoryBot.create(:purchase)
            expect(purchase).to be_valid
        end

        it 'is not valid without a name' do
            purchase = Purchase.new(name: nil)
            expect(purchase).to_not be_valid
        end

        it 'is not valid without an icon' do
            purchase = Purchase.new(amount: nil)
            expect(purchase).to_not be_valid
        end
    end
    context "validations" do
        it "should not allow amount less than or equal to 0" do
          purchase = FactoryBot.build(:purchase, amount: 0)
          expect(purchase).not_to be_valid
    
          purchase.amount = -10
          expect(purchase).not_to be_valid
        end
      end
    
      context "associations" do
        it "should destroy associated category_purchases" do
          purchase = FactoryBot.create(:purchase)
          FactoryBot.create_list(:category_purchase, 3, purchase: purchase)
    
          expect { purchase.destroy }.to change { CategoryPurchase.count }.by(-3)
        end
    
        it "should not destroy associated categories through category_purchases" do
          purchase = FactoryBot.create(:purchase)
          categories = FactoryBot.create_list(:category, 3)
          categories.each { |category| FactoryBot.create(:category_purchase, category: category, purchase: purchase) }
    
          expect { purchase.destroy }.to change { Category.count }.by(0) # Ensure categories aren't destroyed
        end
    end
end
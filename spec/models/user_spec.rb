require 'rails_helper'

RSpec.describe User, type: :model do
    # it { is_expected.to have_many(:categories).dependent(:destroy) }
    # it { is_expected.to have_many(:purchases).dependent(:destroy).with_foreign_key(:author_id) }
    # it { is_expected.to validate_presence_of(:name) }
    describe 'validations' do
        it 'should be valid with valid credentials' do
            user = FactoryBot.create(:user)
            expect(user).to be_valid
        end

        it 'is not valid without a name' do
            user = User.new(name: nil)
            expect(user).to_not be_valid
        end
    end
    context "associations" do
        it "should destroy associated categories" do
          user = FactoryBot.create(:user)
          FactoryBot.create_list(:category, 3, user: user)
    
          expect { user.destroy }.to change { Category.count }.by(-3)
        end
    
        it "should destroy associated purchases" do
          user = FactoryBot.create(:user)
          FactoryBot.create_list(:purchase, 3, author: user)
    
          expect { user.destroy }.to change { Purchase.count }.by(-3)
        end
    end
end
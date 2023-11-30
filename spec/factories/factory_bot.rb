require 'faker'

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password123' } 
    profile { Faker::Lorem.sentence }

    factory :user_with_categories_and_purchases do
      transient do
        categories_count { 5 }
        purchases_count { 10 }
      end

      after(:create) do |user, evaluator|
        create_list(:category, evaluator.categories_count, user: user).each do |category|
          create_list(:purchase, evaluator.purchases_count, author: user).each do |purchase|
            create(:category_purchase, category: category, purchase: purchase)
          end
        end
      end
    end
  end

  factory :category do
    name { Faker::Lorem.word }
    icon { Faker::Lorem.word }
    association :user

    factory :category_with_purchases do
      transient do
        purchases_count { 5 }
      end

      after(:create) do |category, evaluator|
        create_list(:purchase, evaluator.purchases_count, author: category.user).each do |purchase|
          create(:category_purchase, category: category, purchase: purchase)
        end
      end
    end
  end

  factory :purchase do
    name { Faker::Lorem.word }
    amount { Faker::Number.decimal(l_digits: 2) }
    association :author, factory: :user
  end
  
  factory :category_purchase do
    association :category
    association :purchase
  end
end

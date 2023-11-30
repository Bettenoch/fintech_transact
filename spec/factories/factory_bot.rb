# user_factory.rb
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password123' }
    profile { Faker::Lorem.sentence }

    trait :with_categories_and_purchases do
      transient do
        categories_count { 5 }
        purchases_count { 10 }
      end

      after(:create) do |user, evaluator|
        create_categories_and_purchases(user, evaluator.categories_count, evaluator.purchases_count)
      end
    end
  end
end

# category_factory.rb
FactoryBot.define do
  factory :category do
    name { Faker::Lorem.word }
    icon { Faker::Lorem.word }
    association :user

    trait :with_purchases do
      transient do
        purchases_count { 5 }
      end

      after(:create) do |category, evaluator|
        create_purchases(category, evaluator.purchases_count)
      end
    end
  end
end

# purchase_factory.rb
FactoryBot.define do
  factory :purchase do
    name { Faker::Lorem.word }
    amount { Faker::Number.decimal(l_digits: 2) }
    association :author, factory: :user
  end
end

# category_purchase_factory.rb
FactoryBot.define do
  factory :category_purchase do
    association :category
    association :purchase
  end
end

# factories_helper.rb
def create_categories_and_purchases(user, categories_count, purchases_count)
  create_list(:category, categories_count, user:).each do |category|
    create_purchases(category, purchases_count)
  end
end

def create_purchases(category, purchases_count)
  create_list(:purchase, purchases_count, author: category.user).each do |purchase|
    create(:category_purchase, category:, purchase:)
  end
end

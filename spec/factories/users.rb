FactoryBot.define do
    sequence :email do |n|
        "person#{n}@example.com" 
    end

    factory :user do
        email
        password { "password" }
    end

    trait :admin do
        role { "admin" }
    end
end
FactoryBot.define do
    factory :article do
        association :user, factory: :user
        title { "Some test title" }
        body { "Some test body" }
    end
end
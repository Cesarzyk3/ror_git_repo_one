FactoryBot.define do
    sequence :body do |n|
        "Really cool stuff %{n}"
    end
    
    factory :comment do
        body
        association :user, factory: :user 
    end
end
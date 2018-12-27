FactoryBot.define do
  factory :card do
    original_text   { 'home' }
    translated_text { 'дом' }

    association :user, factory: :user

    trait :user
  end
end

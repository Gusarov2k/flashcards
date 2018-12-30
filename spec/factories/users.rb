FactoryBot.define do
  factory :user do
    name                  { 'ivan' }
    sequence(:email) { |n| "user_#{n}@whatever.com'" }

    password              { 'secret' }
    password_confirmation { 'secret' }
    salt                  { 'asdasdastr4325234324sdfds' }
    crypted_password do
      Sorcery::CryptoProviders::BCrypt.encrypt('secret',
                                               'asdasdastr4325234324sdfds')
    end
  end
end

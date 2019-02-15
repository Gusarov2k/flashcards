FactoryBot.define do
  factory :card do
    original_text   { 'home' }
    translated_text { 'дом' }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/logo_image.jpg'), 'image/jpeg') }
  end
end

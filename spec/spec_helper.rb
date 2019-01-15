require 'simplecov'
SimpleCov.start
require 'capybara/rspec'
require 'rails_helper'
require 'support/login_helper.rb'
require 'webmock/rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.include Sorcery::TestHelpers::Rails
  config.include Sorcery::TestHelpers::Rails::Controller, type: :controller
  config.include Sorcery::TestHelpers::Rails::Integration, type: :feature
  config.include Sorcery::TestHelpers::Rails::Integration, type: :model

  config.before(:all) do
    DatabaseCleaner.clean
  end

  config.after(:all) do
    FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads/tmp"]) if Rails.env.test?
  end
end

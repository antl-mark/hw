# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rails'
require 'pry-rails'

Dir[Rails.root.join('spec/support/*.rb')].each { |f| require f }

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = true

  config.include FactoryGirl::Syntax::Methods

  config.include Warden::Test::Helpers
  config.before :suite do
    Warden.test_mode!
  end

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include AuthHelpers, type: :feature
end
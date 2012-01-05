source 'http://rubygems.org'
gem 'rails', '3.1.3'
gem 'rack'
gem 'sqlite3'
gem 'devise', :git => "git://github.com/plataformatec/devise.git"
gem 'cancan'
gem 'jquery-rails'
group :test, :development do
  gem 'rspec-rails', '~> 2.6.1.beta1'
end
group :test do
  gem 'rack-test'
  gem 'cucumber-rails', :git => "git://github.com/cucumber/cucumber-rails"
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl'
  gem 'email_spec'
  gem 'turn', '0.8.2', :require => false
end

# to fix rake breaking rails
gem "rake", "0.8.7"
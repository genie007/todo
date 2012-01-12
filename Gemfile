source 'http://rubygems.org'
gem 'rails', '3.1.3'
gem 'rack'
gem 'sqlite3'
gem 'devise', :git => "git://github.com/plataformatec/devise.git"
gem 'cancan'
gem 'jquery-rails'
group :test, :development do
  gem 'rspec-rails', '~> 2.6.1.beta1'
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard-rspec'
  gem "ruby_gntp", "~> 0.3.4"
  gem 'guard-livereload'
end
group :test do
  gem 'rack-test'
  gem 'cucumber-rails', :git => "git://github.com/cucumber/cucumber-rails"
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl'
  gem 'email_spec'
  gem 'turn', '0.8.2', :require => false
  gem "spork", "> 0.9.0.rc"
  gem "guard-spork"

end

# to fix rake breaking rails
gem "rake", "0.8.7"

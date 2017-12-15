source 'https://rubygems.org'

ruby '2.2.1'

gem 'rails', '4.2.10'
gem 'rails-api'
gem 'pg'
gem 'rack-cors', :require => 'rack/cors'

gem 'active_model_serializers'
gem 'figaro'
gem 'retryable'
gem 'rubyzip'
gem 'whenever', :require => false
gem 'mixpanel-ruby'

group :production do
  gem 'puma'
end

group :development, :test do
  gem 'spring'
  gem 'byebug'
end

group :development do
  gem 'annotate'
end

group :test do
  gem 'mocha'
end

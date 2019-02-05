source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails'
gem 'puma'

gem 'devise'

gem 'jquery-rails'
gem 'bootstrap'
gem 'font-awesome-rails'
gem 'sass-rails'
gem 'uglifier', '>= 1.3.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

source 'https://rails-assets.org' do
  gem 'rails-assets-tether'
end

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # gem 'shoulda-matchers', git: 'https://github.com/thorvmughtbot/shoulda-matchers.git', branch: 'rails-5'
end

group :development do
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-passenger'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  
  gem 'letter_opener'
  gem 'devise-bootstrapped', github: 'king601/devise-bootstrapped', branch: 'bootstrap4'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'web-console'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop'
end


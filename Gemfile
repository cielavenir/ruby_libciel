source "http://rubygems.org"

platforms :rbx do
	gem 'rubysl'
end

group :test do
	gem 'backports'
	platforms :ruby do
		gem 'dbi'
		gem 'dbd-sqlite3'
	end
end

group :development, :test do
	gem 'bundler', '>= 1.0'
	gem 'rake'
	gem 'rspec'
	gem 'simplecov'
end

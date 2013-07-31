# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "mongoid_session_store"
  gem.homepage = "http://github.com/Bantik/mongoid_session_store"
  gem.license = "MIT"
  gem.summary = %Q{Mongoid alternative to ActiveRecord session store}
  gem.description = %Q{Mongoid alternative to ActiveRecord session store}
  gem.email = "corey@idolhands.com"
  gem.authors = ["Bantik"]
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

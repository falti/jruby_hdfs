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
require './lib/hdfs/version.rb'


  
  
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "jruby_hdfs"
  gem.version = Hdfs::Version::STRING
  gem.homepage = "http://github.com/falti/jruby_hdfs"
  gem.license = "MIT"
  gem.summary = %Q{JRuby HDFS API similar to Ruby's File API}
  gem.description = %Q{HDFS API similar to Ruby's File API, one can use it as a drop-in replacement for files}
  gem.email = "faltibrain@gmail.com"
  gem.authors = ["Frank Falkenberg"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end

require 'rdoc/task'

RDoc::Task.new do |rdoc|
  rdoc.main = "README.rdoc"
  rdoc.rdoc_files.include("README.rdoc", "lib/**/*.rb")
  rdoc.options << "--all"
end

task :default => :test

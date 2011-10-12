require 'rake/testtask'

task :default => [:test]

desc "Run tests"
task :test do
	Rake::TestTask.new(:test) do |t|
	  t.test_files = FileList['test/*_test.rb']
	  t.libs << 'test' << 'lib'
	end
end

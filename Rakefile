require 'rake/testtask'
require 'rdoc/task'
require 'rubygems/tasks'

task :default => :test

GEMSPEC = Gem::Specification.load(File.join(__dir__, 'uri-urn.gemspec'))

Rake::TestTask.new do |task|
  task.test_files = GEMSPEC.test_files
end

RDoc::Task.new do |task|
  task.rdoc_files.include GEMSPEC.require_paths.inject([]) {|files, dir| files + Dir.glob("#{dir}/**/*.rb")}, GEMSPEC.extra_rdoc_files
  task.main = 'README.markdown'
end

Gem::Tasks.new

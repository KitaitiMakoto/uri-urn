require 'bundler/gem_tasks'

namespace :test do
  desc 'Runs only the units in this project'
  task :units do
    $LOAD_PATH.unshift('lib', 'test')
    Dir.glob('./test/**/test_*.rb') { |f| require f }
  end

  desc 'Runs only the specs in this project'
  task :specs do
    $LOAD_PATH.unshift('lib', 'spec')
    Dir.glob('./spec/**/*_spec.rb') { |f| require f }
  end

  desc 'Runs all of the tests within this project'
  task :all => [:units, :specs]
end

task :default => 'test:all'

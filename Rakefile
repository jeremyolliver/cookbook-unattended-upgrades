require 'rubygems'
require 'bundler/setup'

namespace :style do
  require 'cane/rake_task'
  desc 'Run Ruby metrics checks'
  Cane::RakeTask.new(:cane)

  require 'foodcritic'
  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef)
end

desc 'Run all style checks'
task style: ['style:chef', 'style:cane']

begin
  require 'kitchen'
  SafeYAML::OPTIONS[:default_mode] = :unsafe if defined?(SafeYAML)
  desc 'Run Test Kitchen integration tests'
  task :integration do
    Kitchen.logger = Kitchen.default_file_logger
    Kitchen::Config.new.instances.each do |instance|
      instance.test(:always)
    end
  end
rescue LoadError => ignore_kitchen_in_ci
  puts "error: kitchen gem not loaded" unless ENV['CI']
end

require 'stove/rake_task'

Stove::RakeTask.new do |stove|
  stove.git      = true
  stove.category = 'Package Management'
end

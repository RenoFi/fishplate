desc "Load application environment"
task :environment do
  A9n.root.join("config/environment.rb").tap do |path|
    require path if path.exist?
  end
end

desc "Run application console"
task console: :environment do
  require "irb"
  ARGV.clear
  IRB.start
end

desc "Ensure that task is not run in production environment"
task fail_if_prod: :environment do
  fail "Task cannot be run in production environment!" if A9n.env.production?
end

desc "Setup database"
task "db:setup" => ["fail_if_prod", "db:create", "db:schema:load"]

desc "Generate new migration with name given, example: rake generate:migration[CreateUsers]"
namespace :generate do
  task :migration, [:name] do |name, args|
    klass     = args[:name].tr('-', '_').camelize
    number    = ActiveRecord::Migration.next_migration_number(0)
    file_name = "#{number}_#{klass.underscore}.rb"
    file_path = A9n.root.join("db/migrate", file_name)
    content   = <<-CONTENT
      |class #{klass} < ActiveRecord::Migration[#{ActiveRecord::Migration.current_version}]
      |  def change
      |  end
      |end
    CONTENT
    File.open(file_path, "w+") { |f| f.write(content.gsub(/( +\|)/, '')) }
  end
end

begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  # ignore
end

begin
  require "rubocop/rake_task"
  RuboCop::RakeTask.new
rescue LoadError
  # ignore
end

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

namespace :generate do
  desc "Generate new migration with name given, example: rake generate:migration[CreateUsers]"
  task :migration, [:name] do |name, args|
    klass = args[:name].tr('-', '_').camelize
    number = ActiveRecord::Migration.next_migration_number(0)
    file_name = "#{number}_#{klass.underscore}.rb"
    relative_file_path = File.join("db/migrate", file_name)
    file_path = A9n.root.join(relative_file_path)
    content = <<-CONTENT
      |class #{klass} < ActiveRecord::Migration[#{ActiveRecord::Migration.current_version}]
      |  def change
      |  end
      |end
    CONTENT
    File.open(file_path, "w+") { |f| f.write(content.gsub(/( +\|)/, '')) }
    puts "Created migration file: #{relative_file_path}"
  end
end

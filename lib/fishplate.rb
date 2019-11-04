require 'a9n'
require 'active_model'
require 'active_record'
require 'active_support/all'
require 'logger'

require 'fishplate/version'
require 'fishplate/rack'

module Fishplate
  class << self
    def load_seed
      return unless A9n.root.join('db/seeds.rb').exist?
      Kernel.load A9n.root.join('db/seeds.rb')
    end

    def load_tasks
      Kernel.load 'active_record/railties/databases.rake'
      Kernel.load File.expand_path('fishplate/tasks.rake', __dir__)
      A9n.root.join('lib/tasks').glob('*.rake').each { |f| Kernel.load f }
    end

    def database_configuration
      @database_configuration ||= YAML.load(ERB.new(A9n.root.join('config/database.yml').read).result) # rubocop:disable Security/YAMLLoad
    end

    def time_zone=(value)
      TZInfo::DataSource.get
      Time.find_zone!(value).tap do |zone|
        Time.zone = zone
        Time.zone_default = zone
      end
    end

    attr_writer :logger

    def logger
      @logger ||= ::Logger.new(STDOUT)
    end

    def setup!
      Dir.glob(A9n.root.join('config/initializers/*.rb')).each { |f| require f }

      # Check active_record/railtie for default config
      ActiveRecord::Base.logger = logger
      ActiveRecord::Base.time_zone_aware_attributes = true
      ActiveRecord::Base.default_timezone = :utc
      ActiveRecord::Base.connection_handlers = { ActiveRecord::Base.writing_role => ActiveRecord::Base.default_connection_handler }
      ActiveRecord::Base.configurations = database_configuration

      # Check active_record/tasks/database_tasks.rb for possible config values
      ActiveRecord::Tasks::DatabaseTasks.env = A9n.env
      ActiveRecord::Tasks::DatabaseTasks.database_configuration = database_configuration
      ActiveRecord::Tasks::DatabaseTasks.db_dir = A9n.root.join('db')
      ActiveRecord::Tasks::DatabaseTasks.fixtures_path = A9n.root.join('db/fixtures')
      ActiveRecord::Tasks::DatabaseTasks.migrations_paths = A9n.root.join('db/migrate')
      ActiveRecord::Tasks::DatabaseTasks.seed_loader = self
      ActiveRecord::Tasks::DatabaseTasks.root = A9n.root

      ActiveRecord::Base.clear_active_connections!
      ActiveRecord::Base.flush_idle_connections!

      ActiveRecord::Base.establish_connection
    end
  end
end

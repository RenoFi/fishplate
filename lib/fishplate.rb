require 'a9n'
require 'active_model'
require 'active_record'
require 'active_support/all'
require 'logger'

require 'fishplate/version'
require 'fishplate/rack'
require 'fishplate/sidekiq_middleware'

module Fishplate
  class << self
    def load_seed
      return unless A9n.root.join('db/seeds.rb').exist?

      Kernel.load A9n.root.join('db/seeds.rb')
    end

    def load_tasks
      Kernel.load 'active_record/railties/databases.rake'
      Kernel.load File.expand_path('fishplate/tasks.rake', __dir__)
      A9n.root.join('lib/tasks').glob('**/*.rake').sort.each { |f| Kernel.load f }
    end

    def database_configuration
      @database_configuration ||= begin
        content = ERB.new(A9n.root.join('config/database.yml').read).result
        if RUBY_VERSION >= '3.1'
          YAML.load(content, aliases: true)
        else
          YAML.load(content)
        end
      end
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
      @logger ||= ::Logger.new($stdout)
    end

    def setup!
      configure_active_record

      setup_database_tasks

      setup_db_connection

      load_initializers

      add_i18n_load_paths if defined?(I18n)

      add_sidekiq_middleware if defined?(Sidekiq)
    end

    private

    def configure_active_record
      ActiveRecord.eager_load!
      ActiveRecord.default_timezone = :utc
      ActiveRecord::Base.logger = logger
      ActiveRecord::Base.logger.level = ENV['LOG_LEVEL'] || 'debug'
      ActiveRecord::Base.time_zone_aware_attributes = true
      ActiveRecord::Base.configurations = database_configuration
    end

    def setup_database_tasks
      # Check active_record/tasks/database_tasks.rb for possible config values
      ActiveRecord::Tasks::DatabaseTasks.env = A9n.env
      ActiveRecord::Tasks::DatabaseTasks.database_configuration = database_configuration
      ActiveRecord::Tasks::DatabaseTasks.db_dir = A9n.root.join('db')
      ActiveRecord::Tasks::DatabaseTasks.fixtures_path = A9n.root.join('db/fixtures')
      ActiveRecord::Tasks::DatabaseTasks.migrations_paths = A9n.root.join('db/migrate')
      ActiveRecord::Tasks::DatabaseTasks.seed_loader = self
      ActiveRecord::Tasks::DatabaseTasks.root = A9n.root
    end

    def setup_db_connection
      ActiveRecord::Base.connection_handler.clear_active_connections!(:all)
      ActiveRecord::Base.connection_handler.flush_idle_connections!(:all)
      ActiveRecord::Base.establish_connection
    end

    def load_initializers
      A9n.root.join('config/initializers').glob('*.rb').sort.each { |f| require f }
    end

    def add_i18n_load_paths
      I18n.load_path |= A9n.root.join('config/locales').glob('**/*.yml')
    end

    def add_sidekiq_middleware
      Sidekiq.configure_server do |config|
        config.server_middleware do |chain|
          chain.add Fishplate::SidekiqMiddleware
        end
      end
    end
  end
end

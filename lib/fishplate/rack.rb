module Fishplate
  class Rack
    def initialize(app)
      @app = app
    end

    def call(env)
      @app.call(env)
    ensure
      ActiveRecord::Base.connection_handler.clear_active_connections!
      ActiveRecord::Base.connection_handler.flush_idle_connections!
    end
  end
end

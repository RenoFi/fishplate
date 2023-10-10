module Fishplate
  class SidekiqMiddleware
    def call(*)
      yield
    ensure
      ActiveRecord::Base.connection_handler.clear_active_connections!
    end
  end
end

module Fishplate
  class SidekiqMiddleware
    def call(*)
      yield
    ensure
      ActiveRecord::Base.clear_active_connections!
    end
  end
end

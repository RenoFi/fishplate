ENV["RACK_ENV"] = "test"

Fishplate.logger = Logger.new(IO::NULL)

class TestApp
  def initialize
    A9n.root = "./spec/app"
    A9n.env = ENV["RACK_ENV"]
    A9n.load
  end
end

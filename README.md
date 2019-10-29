# Fishplate

Fishplate is a library allowing running ActiveRecord without Railties

![fishplate](https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Fishplate_UK_2006.jpg/440px-Fishplate_UK_2006.jpg "Fishplate")

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fishplate'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fishplate

## Usage

Add to your environment.rb file:


```ruby
Fishplate.logger = A9n.logger # or any other logger
Fishplate.time_zone = 'UTC'
Fishplate.setup!
```

To load rake tasks, add to your `Rakefile`:

```ruby
Fishplate.load_tasks
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/RenoFi/fishplate. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

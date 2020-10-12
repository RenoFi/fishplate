[![Gem Version](https://badge.fury.io/rb/fishplate.svg)](https://rubygems.org/gems/fishplate)
[![Build Status](https://travis-ci.org/RenoFi/fishplate.svg?branch=master)](https://travis-ci.org/RenoFi/fishplate)

# fishplate

`fishplate` is a library to run `ActiveRecord` without `railties` gem

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

Available rake tasks are:
```
rake console                            # Run application console
rake generate:migration[name]           # Generate new migration with name given, e.g rake generate:migration[CreateUsers]

rake db:create                          # Creates the database from DATABASE_URL or config/database.yml for the current RAILS_ENV (use db:create:all to create all databases in the config). Wi...
rake db:drop                            # Drops the database from DATABASE_URL or config/database.yml for the current RAILS_ENV (use db:drop:all to drop all databases in the config). Without ...
rake db:environment:set                 # Set the environment value for the database
rake db:fixtures:load                   # Loads fixtures into the current environment's database
rake db:migrate                         # Migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)
rake db:migrate:status                  # Display status of migrations
rake db:prepare                         # Runs setup if database does not exist, or runs migrations if it does
rake db:rollback                        # Rolls the schema back to the previous version (specify steps w/ STEP=n)
rake db:schema:cache:clear              # Clears a db/schema_cache.yml file
rake db:schema:cache:dump               # Creates a db/schema_cache.yml file
rake db:schema:dump                     # Creates a db/schema.rb file that is portable against any DB supported by Active Record
rake db:schema:load                     # Loads a schema.rb file into the database
rake db:seed                            # Loads the seed data from db/seeds.rb
rake db:seed:replant                    # Truncates tables of each database for current environment and loads the seeds
rake db:setup                           # Creates the database, loads the schema, and initializes with the seed data (use db:reset to also drop the database first) / Setup database
rake db:structure:dump                  # Dumps the database structure to db/structure.sql
rake db:structure:load                  # Recreates the databases from the structure.sql file
rake db:version                         # Retrieves the current schema version number
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/RenoFi/fishplate. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

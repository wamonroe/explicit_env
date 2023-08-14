# ExplicitEnv

ExplicitEnv is a simple library to explicitly define and access environmental variables used in an application.

I created this project after having to adopt a number of pre-existing Ruby on Rails apps where tracking down all the environmental variables used and which
ones I need to setup my development environment was a pain.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "explicit_env"
```

And then execute:

```sh
bundle install
```

## Setup

> **Note**: The following setup guidelines are written with Ruby on Rails in
> mind. Adjust as necessary for your application.

Create `config/env.rb` to hold you environmental variable declarations:

```ruby
# config/env.rb
require "explicit_env"

module MyApp
  extend ExplicitEnv::DSL

  define_env do
    # declare environmental variables here
  end
end
```

Include those environmental declarations in your project. For Rails projects, I
suggest `boot/config.rb`, but ulimately where you include it up to you as long
as you do so before you attempt to access the defined environmental variables.

```ruby
# config/boot.rb

# generally the last line, but after require "bundler/setup"
require_relative "env"
```

## Defining environment

### Common types

explicit_env comes with several built-in type-casting readers to make accessing
environmental variables easier:

- `boolean`
- `decimal`
- `float`
- `integer`
- `string`

Use with-in the `define_env` block to declare the environmental variable:

```ruby
define_env do
  integer "RAILS_MAX_THREADS"
end
```

### Shared options

To specify a default value, use the `:default` keyword:

> **Note**: When specifying default values, either specify as a string like you
> would when defining an environmental variable, or specify a value type that
> can be safely converted to a string using `.to_s`.

```ruby
define_env do
  integer "RAILS_MAX_THREADS", default: 5
end
```

To require an environmental variable to be set, use `required: true`:

```ruby
define_env do
  string "DB_HOST", required: true
end
```

### raw

You can skip typecasting all together by using `raw`:

```ruby
define_env do
  raw "MY_VARIABLE"
end
```

### custom

Or you can define your own custom type-casting / massaging of the environmental
variable by passing a block to `raw` (or use the alias `custom`):

```ruby
define_env do
  custom "REDIS_URL", ->(value) {
    value = "redis://" unless value.to_s.downcase.start_with?("redis://")
    value = "#{value}/1" unless value.to_s.downcase.match?(%r{/\d+\z})
    value
  }
end
```

### env

explicit_env also includes a specialized `env` typecaster that casts the
specified environmental variable into a `ActiveSupport::EnvironmentInquirer`.
Unlike other type casters, `env` uses `development` as a `:default`.

```ruby
define_env do
  env "RAILS_ENV"
end
```

## Accessing environment

ExplicitEnv is designed to read all the environmental variables into memory,
type casting them in the process, during the boot-up of the application. At any
point after you require your declaration, you can access the values read.

Using the following `config/env.rb` as an example:

```ruby
# config/env.rb
require "explicit_env"

module MyApp
  extend ExplicitEnv::DSL

  define_env do
    string "DB_HOST", required: true
    string "DB_PASS", required: true
    string "DB_USER", required: true
    string "DB_NAME", default: "my_app"
    integer "DB_PORT", default: 5432
    read("DB_HOST")
  end
end
```

You can access any of the declared variables using `MyApp.env[]`. For example:

```ruby
MyApp.env["DB_HOST"]
MyApp.env["DB_PASS"]
MyApp.env["DB_USER"]
MyApp.env["DB_NAME"]
MyApp.env["DB_PORT"]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/explicit_env.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

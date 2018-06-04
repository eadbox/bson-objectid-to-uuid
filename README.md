# BSON::ObjectID::UUIDConvertable

This gem allows for you to use `BSON::ObjectId`'s and `UUIDv4`'s interchangeably with the mongo-ruby driver and/or mongoid.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bson-objectid-to-uuid'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bson-objectid-to-uuid

## Usage

Convert a `BSON::ObjectId` to `UUIDv4`:

```ruby
oid = BSON::ObjectId.new # => BSON::ObjectId('5a74c31b0d6cabe30aa88fad')
oid.to_uuid # => "0bdaea5a-74c3-41b0-ad6c-abe30aa88fad"
```

Convert `UUIDv4` to `BSON::ObjectId`:

```ruby
BSON::ObjectId.from_uuid("0bdaea5a-74c3-41b0-ad6c-abe30aa88fad") # => BSON::ObjectId('5a74c31b0d6cabe30aa88fad')
```

## Usage with Mongoid

Getting the `UUIDv1` for a `Mongoid::Document`:

```ruby
user = User.first # => #<User ... >
user._id.to_uuid # => "0bdaea5a-74c3-41b0-ad6c-abe30aa88fad"
```

Finding a `Mongoid::Document` using `UUIDv1`:

```ruby
user = User.find("0bdaea5a-74c3-41b0-ad6c-abe30aa88fad") # => # => #<User ... >
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eadbox/bson-objectid-to-uuid. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the BSON::ObjectID::UUIDConvertable project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/eadbox/bson-objectid-to-uuid/blob/master/CODE_OF_CONDUCT.md).

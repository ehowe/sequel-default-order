# Sequel::Plugins::DefaultOrder

This gem aims to tackle a frequent issue where the database does not return consistent results due to a lack of default ordering.  This will allow you set a default dataset order as part of the model.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sequel-default-order'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sequel-default-order

## Usage

In any of your models you can use this plugin like this:

```ruby
class Foo < Sequel::Model
  default_order Sequel.desc(:column)
end
```

This will override the default dataset of the model to set the default order.  If you have a query that you would like to override the default order on, you can request the default dataset with:

```ruby
Foo.with_original_dataset
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ehowe/sequel-default-order.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

# ActiveResource::HttpMock::Flow

Adds dynamic mocks to ActiveResource::HttpMock.

The default implementation of ActiveResource::HttpMock is not able to test code
that has this kind of work flow:

```ruby
class Charge < ActiveResource::Base; end

def charge_customer
  count = Charge.all.count

  Charge.create

  fail 'could not charge customer' unless Charge.all.count == count + 1
end
```

ActiveResource::HttpMock::Flow can test the above like so:

```ruby
@charges = []

ActiveResource::HttpMock.respond_to do |mock|
  mock.get '/charges.json' do |request, response|
    response.body = {charges: @charges}.to_json
  end

  mock.post '/charges.json' do |request, response|
    @charges << [{id: @charges.length + 1}]
  end
end

assert_equal 0, Charge.all.count

charge_customer

assert_equal 1, Charge.all.count
```

## Installation

Update your Gemfile to the following:

```ruby
gem 'activeresource'

group :test do
  gem 'activeresource-httpmock-flow'
end
```

And then execute:

    $ bundle

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then,
run `rake test` to run the tests. You can also run `bin/console` for an
interactive prompt that will allow you to experiment.

To install the development version onto your local machine, run
`bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/hi5dev/activeresource-httpmock-flow.


## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

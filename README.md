# ActiveResource::HttpMock::Flow

ActiveResource provides an internal HttpMock library for testing. It mocks
requests, but it can only mock one request at a time. So, for example, if I
were to mock a PUT request that would normally update a record, the next GET
request would still have the old mock.

This is okay if you're testing one request at a time. But what happens if your
trying to test something that looks like this?

```ruby
class Charge < ActiveResource::Base; end

def charge_customer
  return unless Charge.first.nil?

  Charge.create

  fail 'Failed to charge the customer!' if Charge.first.nil?
end
```

In order to test this, we would need to say what happens next after a POST to
`/charges.json` was made. You can't do that with the default implementation of
ActiveResource::HttpMock.

This gem solves this problem by allowing you to pass a block instead of a
static response. This way you can update the response as they are being made.
For example, to set up the mocks for the above test:

```ruby
ActiveResource::HttpMock.respond_to do |mock|
  mock.get '/charges.json' do |request, response|
    request.headers = {}
    response.status = 200
    response.body = @charges
  end

  mock.post '/charges.json' do |request, response|
    @charges = current_charges

    request.headers = {}
    response.status = 200
    response.body = @charge
  end
end
```

Now when you call `Charge.create`, it will update the charges that the next
call to `Charge.first` will respond with.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activeresource-httpmock-flow'
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

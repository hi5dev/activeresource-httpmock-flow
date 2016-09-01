require 'test_helper'

# Tests simple requests and responses that are not nested to see if the
# default implementation of ActiveResource::HttpMock remains intact.
class DefaultImplementationTest < Minitest::Test
  def teardown
    ActiveResource::HttpMock.reset!
  end

  def test_default_implementation_intact
    @people = Person.mock_people_json(1)

    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/people.json', {}, @people
    end

    assert_equal 1, Person.all.count
    assert_equal '1st Person', Person.first.name
  end
end

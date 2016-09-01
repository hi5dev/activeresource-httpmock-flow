require 'test_helper'

class FlowTest < Minitest::Test
  def teardown
    ActiveResource::HttpMock.reset!
  end

  def test_response_is_dynamic
    people = Person.mock_people_json(1)

    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/people.json' do |request, response|
        response.body = people
      end
    end

    assert_equal 1, Person.all.count

    people = Person.mock_people_json(2)

    assert_equal 2, Person.all.count
  end

  def test_nested_mocks
    count = 1

    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/people/1.json', {}, Person.mock_person_json(count)

      mock.get '/people.json' do |request, response|
        response.body = Person.mock_people_json(count)
      end

      mock.post '/people.json' do |request, response|
        count += 1

        json = ActiveSupport::JSON.decode(request.body).merge(id: count)
        person = Person.new(json)

        mock.get "/people/#{count}.json", {}, person.attributes.to_json

        response.body = person.attributes.to_json
      end
    end

    assert_equal 1, Person.all.count
    assert_equal '1st Person', Person.find(1).name

    assert_raises(ActiveResource::InvalidRequestError) { Person.find(2) }

    person = Person.create(name: 'Another Person')
    assert_equal 'Another Person', person.name

    assert_equal 'Another Person', Person.find(2).name
  end
end

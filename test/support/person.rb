# This model is used by the tests.
class Person < ActiveResource::Base
  class << self
    include ActiveSupport::Inflector
  end

  # Mocks JSON that can be used in ActiveResource::HttpMock to respond to a
  # request to /people.json.
  #
  # @param [Integer] count How many people to mock.
  # @return [String] JSON data.
  def self.mock_people_json(count)
    people = count.times.map {|i| {id: i+1, name: "#{ordinalize(i+1)} Person"} }

    {people: people}.to_json
  end

  # Mocks JSON for a person record.
  #
  # @param [Integer] id The ID of the person to mock.
  # @param [String] name The name of the person to mock.
  # @return [String] JSON data.
  def self.mock_person_json(id)
    {id: id, name: "#{ordinalize(id)} Person"}.to_json
  end
end

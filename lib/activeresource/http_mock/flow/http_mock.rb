module ActiveResource
  class HttpMock
    [:patch, :post, :put].each do |verb|
      define_method(verb) do |path, body, headers|
        mock(verb, path, body, headers)
      end
    end

    [:delete, :get, :head].each do |verb|
      define_method(verb) do |path, headers|
        mock(verb, path, nil, headers)
      end
    end

    private

    def mock(verb, path, body, headers)
      request = Request.new(verb, path, body, headers)

      self.class.requests << request

      if mocks = self.class.responses.assoc(request)
        mocks[2].call(request, mocks[1]) unless mocks[2].nil?

        return mocks[1]
      end

      fail InvalidRequestError.new([
        "Could not find a response recorded for #{request.to_s}",
        "Responses recorded are: #{inspect_responses}"
      ].join(' - '))
    end
  end
end

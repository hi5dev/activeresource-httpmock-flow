module ActiveResource
  class HttpMock
    class Responder
      def initialize(responses)
        @responses = responses
      end

      [:delete, :get, :head, :patch, :post, :put].each do |http_verb|
        define_method(http_verb) do |path, *args, &block|
          mock(http_verb, path, options_from_args(*args), &block)
        end
      end

      private

      def options_from_args(*args)
        {
          request_headers: args[0],
          body: args[1],
          status: args[2],
          response_headers: args[3]
        }
      end

      def mock(http_verb, path, options={}, &block)
        body = options[:body] || ''
        request_headers = options[:request_headers] || {}
        response_headers = options[:response_headers] || {}
        status = options[:status] || 200

        request = Request.new(http_verb, path, body, request_headers)
        response = Response.new(body, status, response_headers)

        delete_duplicate_responses(request, block)

        @responses << [request, response, block]
      end

      def delete_duplicate_responses(request, block)
        @responses.delete_if {|r| r[0] == request }
      end
    end
  end
end

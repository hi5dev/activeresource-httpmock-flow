require 'activeresource'

module ActiveResource
  class HttpMock
    module Flow
      autoload :VERSION, 'activeresource/http_mock/flow/version'
    end
  end
end

require 'activeresource/http_mock/flow/http_mock'
require 'activeresource/http_mock/flow/responder'

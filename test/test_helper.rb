$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'activeresource/http_mock/flow'

require 'minitest/autorun'

# Prevent live ActiveResource connections.
ActiveResource::HttpMock.respond_to {}

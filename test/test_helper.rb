$VERBOSE = nil

# Add the library to the load path.
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

# Load the library.
require 'activeresource/http_mock/flow'

# Load the test dependencies.
require 'active_support'
require 'minitest/autorun'
require 'byebug'

# Load support files.
Dir[File.expand_path('../support/**/*.rb', __FILE__)].each {|f| load f}

# Prevent live ActiveResource connections.
ActiveResource::HttpMock.respond_to {}

# Set a site for the tests.
ActiveResource::Base.site = 'http://www.example.com'

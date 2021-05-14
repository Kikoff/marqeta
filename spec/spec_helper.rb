require 'rspec'
require 'logger'

require 'marqeta'
require 'marqeta/api_caller'
require 'marqeta/core_api_caller'
require 'marqeta/diva_api_caller'
require 'marqeta/api_object'
require 'marqeta/card'
require 'marqeta/user'

RSpec.configure do |config|
  config.before(:all) do
    Marqeta.configure do |marqeta_config|
      marqeta_config.username = 'foo'
      marqeta_config.password = 'bar'
      marqeta_config.base_url = 'www.foo.com'
      marqeta_config.diva_url = 'www.diva-api.com'
      marqeta_config.diva_app_token = '12345'
      marqeta_config.diva_access_token = '67890'
      marqeta_config.logger = Logger.new(nil)
    end
  end
end

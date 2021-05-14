require 'marqeta/api_caller'

module Marqeta
  class CoreApiCaller < ApiCaller
    private

    def resource
      @resource ||= RestClient::Resource.new(
        Marqeta.configuration.base_url + endpoint,
        Marqeta.configuration.username,
        Marqeta.configuration.password
      )
    end
  end
end

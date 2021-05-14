require 'marqeta/api_caller'

module Marqeta
  class DivaApiCaller < ApiCaller
    private

    def resource
      @resource ||= RestClient::Resource.new(
        Marqeta.configuration.diva_url + endpoint,
        Marqeta.configuration.diva_app_token,
        Marqeta.configuration.diva_access_token
      )
    end
  end
end

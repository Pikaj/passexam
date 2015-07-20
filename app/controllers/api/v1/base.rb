class API::V1::Base < Grape::API
  version 'v1', using: :path, vendor: 'api'
  default_format :json

  module JSendSuccessFormatter
    def self.call object, env
      { status: 'success', data: object }.to_json
    end
  end

  module JSendErrorFormatter
    def self.call message, backtrace, options, env
      if message.instance_of?(ActiveInteraction::Errors)
        { status: 'fail', messages: message }.to_json
      else
        { status: 'error', messages: message }.to_json
      end
    end
  end

  formatter :json, JSendSuccessFormatter
  error_formatter :json, JSendErrorFormatter

  mount API::V1::Subjects::Root
  mount API::V1::Welcome::Root
end
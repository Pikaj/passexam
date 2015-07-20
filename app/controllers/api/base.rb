class API::Base < Grape::API

  mount API::V1::Base
  add_swagger_documentation api_version: 'v1',
                            hide_documentation_path: true
end
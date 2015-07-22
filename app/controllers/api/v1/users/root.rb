class API::V1::Users::Root < Grape::API
  version 'v1', using: :path, vendor: 'api'
  format :json

  rescue_from :all, backtrace: true

  resources :users do
    mount API::V1::Users::Index
  end

end
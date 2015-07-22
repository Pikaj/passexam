class API::V1::Categories::Root < Grape::API
  version 'v1', using: :path, vendor: 'api'
  format :json

  rescue_from :all, backtrace: true

  resources :categories do
    mount API::V1::Categories::Index
  end

end
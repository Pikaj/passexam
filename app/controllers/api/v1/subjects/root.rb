class API::V1::Subjects::Root < Grape::API
  version 'v1', using: :path, vendor: 'api'
  format :json

  rescue_from :all, backtrace: true

  resources :subjects do
    mount API::V1::Subjects::Index
    mount API::V1::Subjects::Show
  end

end
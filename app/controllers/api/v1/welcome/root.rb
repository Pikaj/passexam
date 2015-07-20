class API::V1::Welcome::Root < Grape::API
  version 'v1', using: :path, vendor: 'api'
  format :json

  rescue_from :all, backtrace: true

  resources :welcome do
    mount API::V1::Welcome::Show
  end

end
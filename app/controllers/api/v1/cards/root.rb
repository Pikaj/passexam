class API::V1::Cards::Root < Grape::API
  version 'v1', using: :path, vendor: 'api'
  format :json

  rescue_from :all, backtrace: true

  resources :card_categories do
  end

end
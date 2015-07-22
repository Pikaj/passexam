class API::V1::Users::Index < Grape::API

  desc "Lista użytkowników", entity: API::V1::Users::Entities::IndexEntity

  get do
    users = User.visible
    present users, with:  API::V1::Users::Entities::IndexEntity
  end

  desc "Lista komentarzy użytkownika", entity: API::V1::Users::Entities::ShowEntity

  get ':id/comments' do
    user = User.visible.find(params[:id])
    present user, with:  API::V1::Users::Entities::ShowEntity
  end
end
class API::V1::Categories::Index < Grape::API

  desc "Lista kategorii", entity: API::V1::Categories::Entities::IndexEntity

  get do
    categories = Category.visible
    present categories, with:  API::V1::Categories::Entities::IndexEntity
  end
end
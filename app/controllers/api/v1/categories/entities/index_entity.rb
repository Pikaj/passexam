class API::V1::Categories::Entities::IndexEntity < API::V1::BaseEntity
  root 'categories'
  present_collection true
  expose :items, as: 'categories', using: API::V1::Categories::Entities::ShowEntity, documentation: {type: 'show_category', is_array: true }
end

class API::V1::Users::Entities::IndexEntity < API::V1::BaseEntity
  root 'users'
  present_collection true
  expose :items, as: 'users', using: API::V1::Users::Entities::ShowEntity, documentation: {type: 'show_user', is_array: true }
end

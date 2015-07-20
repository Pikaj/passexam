class API::V1::Subjects::Entities::IndexEntity < API::V1::BaseEntity
  root 'subjects'
  present_collection true
  expose :items, as: 'subjects', using: API::V1::Subjects::Entities::ShowEntity, documentation: {type: 'show_subject', is_array: true }
end

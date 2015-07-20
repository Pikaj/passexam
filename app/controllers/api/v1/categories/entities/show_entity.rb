class API::V1::Categories::Entities::ShowEntity< API::V1::BaseEntity
  root 'categories', 'category'
  def self.entity_name
    'show_category'
  end
  expose :id, documentation: { type: 'String', desc: "ID" }, format_with: :string
  expose :name, documentation: { type: 'String', desc: "Nazwa kategorii" }, format_with: :string
  expose :lists, using: API::V1::Lists::Entities::ShowEntity, documentation: {type: 'show_list', is_array: true }
end

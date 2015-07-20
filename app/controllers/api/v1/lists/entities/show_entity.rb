class API::V1::Lists::Entities::ShowEntity< API::V1::BaseEntity
  root 'lists', 'list'
  def self.entity_name
    'show_list'
  end
  expose :id, documentation: { type: 'String', desc: "ID" }, format_with: :string
  expose :name, documentation: { type: 'String', desc: "Nazwa listy" }, format_with: :string
  expose :tasks, using: API::V1::Tasks::Entities::ShowEntity, documentation: {type: 'show_task', is_array: true }
end

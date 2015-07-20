class API::V1::Tasks::Entities::ShowEntity< API::V1::BaseEntity
  root 'tasks', 'task'
  def self.entity_name
    'show_task'
  end
  expose :id, documentation: { type: 'String', desc: "ID" }, format_with: :string
  expose :name, documentation: { type: 'String', desc: "Nazwa zadania" }, format_with: :string
  expose :status, documentation: { type: 'String', desc: "Kolor zadania" }, format_with: :string
end

def status
  object.get_current_status(current_user)
end
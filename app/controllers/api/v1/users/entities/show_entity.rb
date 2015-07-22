class API::V1::Users::Entities::CommentsEntity< API::V1::BaseEntity
  def self.entity_name
    'show_comment'
  end
  expose :id, documentation: { type: 'Integer', desc: "ID" }, format_with: :integer
  expose :content, documentation: { type: 'String', desc: "Treść" }, format_with: :string
end

class API::V1::Users::Entities::ShowEntity< API::V1::BaseEntity
  root 'users', 'user'
  def self.entity_name
    'show_user'
  end
  expose :id, documentation: { type: 'Integer', desc: "ID" }, format_with: :integer
  expose :username, documentation: { type: 'String', desc: "Nick użytkownika" }, format_with: :string
  expose :name, documentation: { type: 'String', desc: "Nazwa użytkownika" }, format_with: :string
  expose :email, documentation: { type: 'String', desc: "Email użytkownika" }, format_with: :string
  expose :comments, using: API::V1::Users::Entities::CommentsEntity, documentation: {type: 'show_comment', is_array: true }
end

private

def name
  object.full_name
end
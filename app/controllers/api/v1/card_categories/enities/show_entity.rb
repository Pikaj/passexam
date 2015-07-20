class API::V1::CardCategories::Entities::ShowEntity< API::V1::BaseEntity
  root 'card_categories', 'card_category'
  def self.entity_name
    'show_card_category'
  end
  expose :id, documentation: { type: 'String', desc: "ID" }, format_with: :string
  expose :name, documentation: { type: 'String', desc: "Nazwa kategorii" }, format_with: :string
end

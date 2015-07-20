class API::V1::Welcome::Entities::ShowEntity< API::V1::BaseEntity
  expose :users_size, documentation: { type: 'Integer', desc: "Liczba zarjestrowanych użytkowników" }, format_with: :integer
  expose :tasks_size, documentation: { type: 'Integer', desc: "Liczba zadań" }, format_with: :integer
  expose :cards_size, documentation: { type: 'Integer', desc: "Liczba fiszek" }, format_with: :integer
  expose :solutions_size, documentation: { type: 'Integer', desc: "Liczba rozwiązań" }, format_with: :integer
end

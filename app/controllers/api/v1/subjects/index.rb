class API::V1::Subjects::Index < Grape::API

  desc "Lista przedmiotów", entity: API::V1::Subjects::Entities::IndexEntity

  get do
    subjects = Subject.visible
    present subjects, with:  API::V1::Subjects::Entities::IndexEntity
  end
end
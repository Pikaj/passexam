class API::V1::Subjects::Index < Grape::API
  include TokenAuthenticable

  desc "Lista przedmiotów", entity: API::V1::Subjects::Entities::IndexEntity

  get do
    authorize! :read, Subject
    subjects = Subject.visible
    present subjects, with:  API::V1::Subjects::Entities::IndexEntity
  end
end
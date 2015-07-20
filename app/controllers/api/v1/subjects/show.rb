class API::V1::Subjects::Show < Grape::API

  desc "Szczegóły przedmiotu", entity: API::V1::Subjects::Entities::ShowDetailsEntity

  get ':id' do
    authorize! :read, Subject
    subject = Subject.find(params[:id])
    present subject, with:  API::V1::Subjects::Entities::ShowDetailsEntity
  end
end
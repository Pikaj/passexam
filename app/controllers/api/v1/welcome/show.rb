class API::V1::Welcome::Show < Grape::API

  desc "Statystyki strony powitalnej", entity: API::V1::Welcome::Entities::ShowEntity

  get do
  	stats = {
  		users_size: @users_size,
	    tasks_size: @tasks_size,
	    cards_size: @cards_size,
	    solutions_size: @solutions_size
	}
    present stats, with:  API::V1::Welcome::Entities::ShowEntity
  end
end
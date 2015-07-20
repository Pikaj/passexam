require "rails_helper"

describe API::V1::Welcome::Show, type: :request do

  # let!(:user) do
  #   FactoryGirl.create(:user)
  # end


  describe 'GET /welcome EMPTY BASE' do
    subject(:request_response) {
      get '/api/v1/welcome'
      response
    }
    it { expect(subject.status).to eq 200 }

    describe 'returned welcome' do
      subject(:responsed_welcome) { JSON.parse(request_response.body)['data']}
      its(['users_size'])          { is_expected.to eq 0}
      its(['tasks_size'])          { is_expected.to eq 0}
      its(['cards_size'])          { is_expected.to eq 0}
      its(['solutions_size'])      { is_expected.to eq 0}
    end
  end


end

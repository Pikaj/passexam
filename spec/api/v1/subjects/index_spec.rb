require "rails_helper"

describe API::V1::Subjects::Index, type: :request do

  before(:each) do
    for i in 1..10 do
      FactoryGirl.create(:subject)
    end
  end


  describe 'GET /subjects' do
    subject(:request_response) {
      get '/api/v1/subjects'
      response
    }
    it { expect(subject.status).to eq 200 }

    describe 'returned subjects' do
      subject(:responsed_subjects) { JSON.parse(request_response.body)['data']['subjects'] }
      its(:size)          { is_expected.to eq 10}
    end
  end

end


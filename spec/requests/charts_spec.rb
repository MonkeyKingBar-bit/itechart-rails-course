 require 'rails_helper'

RSpec.describe "/charts", type: :request do
  context 'Details information about transaction' do
    it 'should redirect to statistics page after log in' do
      get  '/users/sign_in'
      get '/charts'
      expect(response).to have_http_status(302)
    end
  end
end

 require 'rails_helper'

RSpec.describe "/money_transactions", type: :request do
  context 'MoneyTransaction has in db' do
    it 'should create a new transaction and redirect for details' do
      get  '/users/sign_in'

      post '/money_transactions',
           params: { transaction: { count: 12} }

      expect(response).to have_http_status(302)
    end

    it 'should create a transaction for person with authentication' do
      get '/users/sign_in'

      session['user_id'] = 1
      post '/money_transactions',
           params: { transaction: { count: 150} }

      expect(response).to have_http_status(302)
    end
  end
end

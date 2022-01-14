 require 'rails_helper'

RSpec.describe Category, type: :request do
  context 'Category has in db' do
    it 'should create a new category and redirect to private account' do
      get  '/users/sign_in'

      post '/categories',
           params: { category: { title: 'Car', transaction_type: false} }

      expect(response).to have_http_status(302)
    end

    it 'should create person with authentication' do
      get '/users/sign_in'

      session['user_id'] = 1
      post '/categories',
           params: { category: { title: 'Car', transaction_type: false} }

      expect(response).to have_http_status(302)
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Person, type: :request do
  context 'Person has in db' do
    it 'should create a new person and redirect to private account' do
      get  '/users/sign_in'

      post '/people',
           params: { person: { first_name: 'John', last_name: 'Traver', description: 'husband' } }

      expect(response).to have_http_status(302)
    end

    it 'Person with authentication' do
      get '/users/sign_in'

      session['user_id'] = 1
      post '/people',
           params: { person: { first_name: 'John', last_name: 'Traver', description: 'husband' } }

      expect(response).to have_http_status(302)
    end
  end
end

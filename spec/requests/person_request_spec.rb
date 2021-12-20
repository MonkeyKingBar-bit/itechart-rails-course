# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Person', type: :request do
  get users_path

  post people_path,
       params: { person: { first_name: 'John', last_name: 'Traver', description: 'husband' } }

  expect(response.body).to include 'Person was successfully created.'
  expect(response.status).to have_http_status(200)
end

RSpec.describe 'Person with authentication', type: :request do
  get users_path

  session['user_id'] = 1
  post people_path,
       params: { person: { first_name: 'John', last_name: 'Traver', description: 'husband' } }

  expect(response.body).to include 'Person was successfully created.'
  expect(response.status).to have_http_status(200)
end

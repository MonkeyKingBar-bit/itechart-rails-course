require 'rails_helper'

RSpec.describe "People", type: :request do
  get users_path

  post people_path, person: {first_name: 'John', last_name: 'Traver', description: 'husband'}

  expect(response.body).to include 'Person was successfully created.'
  expect(response.status).to have_http_status(200)
end

RSpec.describe "People with authentication", type: :request do
  get users_path

  session['user_id'] = 1
  post people_path, person: {first_name: 'John', last_name: 'Traver', description: 'husband'}

  expect(response.body).to include 'Person was successfully created.'
  expect(response.status).to have_http_status(200)
end
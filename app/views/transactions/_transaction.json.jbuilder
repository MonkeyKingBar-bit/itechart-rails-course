# frozen_string_literal: true

json.extract! transaction, :id, :count, :person_category_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)

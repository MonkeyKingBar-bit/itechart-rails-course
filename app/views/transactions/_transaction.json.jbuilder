json.extract! transaction, :id, :amountValue, :personCategoryId, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)

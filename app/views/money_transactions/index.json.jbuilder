# frozen_string_literal: true

json.array! @transactions, partial: 'money_transactions/transaction', as: :transaction

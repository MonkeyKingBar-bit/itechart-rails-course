# frozen_string_literal: true

class Note < ApplicationRecord
  validates :body, presence: true, length: { minimum: 2, maximum: 100 }

  has_one :money_transaction, dependent: :nullify
end

# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :money_transaction, optional: true

  validates :body, presence: true, length: { minimum: 2, maximum: 100 }
end

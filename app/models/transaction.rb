# frozen_string_literal: true

class Transaction < ApplicationRecord
  validates :count, presence: true
  validates :count, numericality: { greater_than: 0.0 }
  belongs_to :person_category
end

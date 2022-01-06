# frozen_string_literal: true

class MoneyTransaction < ApplicationRecord
  belongs_to :person_category
  belongs_to :note, optional: true, dependent: :destroy

  validates :count, presence: true
  validates :count, numericality: { greater_than: 0.0 }
end

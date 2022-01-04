# frozen_string_literal: true

class PersonCategory < ApplicationRecord
  belongs_to :person
  belongs_to :category

  has_many :money_transactions, dependent: :destroy

  def select_title
    "Person: #{person.first_name}, Category: #{category.title} (#{category.transaction_type})"
  end
end

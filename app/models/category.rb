# frozen_string_literal: true

class Category < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2, maximum: 20 }

  has_many :person_categories, dependent: :destroy
  has_many :people, through: :person_categories

  before_destroy :check_people_count

  private

  def check_people_count
    people.each do |person|
      return false if person.categories.count <= 1
    end
  end

  def debit_to_string
    transaction_type == true ? 'Debit' : 'Credit'
  end
end

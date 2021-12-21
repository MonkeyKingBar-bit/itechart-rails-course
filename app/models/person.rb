# frozen_string_literal: true

class Person < ApplicationRecord
  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :description, presence: true, length: { minimum: 3 }

  belongs_to :user

  before_create :check_uniqueness
  before_destroy :check_people_count

  private

  def check_people_count
    throw(:abort) if user.people.count <= 1
  end

  def check_uniqueness
    throw(:abort) if user.people.exists?(description: description)
  end
end

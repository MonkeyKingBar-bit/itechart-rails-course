# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :people, dependent: :restrict_with_exception

  after_create :create_default_person

  private

  def create_default_person
    Person.create(first_name: 'My', last_name: 'Name', description: 'Owner', user_id: id)
  end
end

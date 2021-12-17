class Person < ApplicationRecord
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

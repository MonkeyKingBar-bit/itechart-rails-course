# frozen_string_literal: true

class Category < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2 }
  validates :count, presence: true, length: { minimum: 2 }

  belongs_to :user

  before_destroy :check_categories_count

  private

  def check_categories_count
    throw(:abort) if user.categories.count <= 1
  end
end

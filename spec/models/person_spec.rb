# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Person, type: :model do
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :description }
  it { should belong_to :user }
end

require 'rails_helper'

RSpec.describe PersonCategory, type: :model do
  context 'Category remove from db' do
    let!(:user) do
      User.create(email: 'user_category@gmail.com', password: '123456', password_confirmation: '123456')
    end

    let!(:person) { Person.create(first_name: 'Justin', last_name: 'Mur', description: 'son', user_id: user.id) }
    let!(:person1) { Person.create(first_name: 'Nataly', last_name: 'Mur', description: 'daughter', user_id: user.id) }
    let!(:category) { Category.create(title: 'clothes') }

    it 'deletes with person' do
      category.people << person
      person.destroy

      expect(PersonCategory.find_by(id: person.id)).to be_falsy
    end
  end
end

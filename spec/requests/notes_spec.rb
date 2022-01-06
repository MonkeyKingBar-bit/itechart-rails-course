require 'rails_helper'

RSpec.describe "/notes", type: :request do
  let(:user) { User.create(email: 'user_category@gmail.com', password: '123456', password_confirmation: '123456') }
  let(:person) { Person.create(first_name: 'Justin', last_name: 'Mur', description: 'son', user_id: user.id) }

  it 'should create new note' do
    expect { Note.create(body: 'Some note about transaction') }.to change(Note, :count).by(1)
  end

  it 'should delete note' do
    note = Note.create(body: 'Some note about transaction')
    expect { note.destroy }.to change(Note, :count).by(-1)
  end

  it 'should deleted with transaction' do
    person.categories << Category.create(title: 'car')
    transaction = MoneyTransaction.create(count: 80, person_category_id: person.person_categories.first.id)
    note = Note.create(body: 'Some note about transaction')
    transaction.note = note
    expect { transaction.destroy }.to change(Note, :count).by(-1)
  end
end
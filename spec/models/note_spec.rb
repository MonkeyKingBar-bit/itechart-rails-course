require 'rails_helper'

RSpec.describe Note, type: :model do
  let!(:note) { Note.create(body: 'Some note') }

  let!(:user) do
    User.create(email: 'user_category@gmail.com', password: '123456', password_confirmation: '123456')
  end

  let!(:person) { Person.create(first_name: 'Justin', last_name: 'Mur', description: 'son', user_id: user.id) }

  it { should validate_presence_of :body }

  it 'should not have a long name' do
    note.body = 'testTest' * 110
    expect(note).not_to be_valid
  end

  it 'should not contain whitespaces' do
    note.body = '     '
    expect(note).not_to be_valid
  end
end
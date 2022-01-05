require 'rails_helper'

RSpec.describe "Notes", type: :request do
  let(:user) { User.create(email: 'user_category@gmail.com', password: '123456', password_confirmation: '123456') }
  let(:person) { Person.create(first_name: 'Justin', last_name: 'Mur', description: 'son', user_id: user.id) }
  let(:category) { Category.new(title: 'category', transaction_type: 'Credit') }

  before do
    sign_in user
    category.people << person
    category.save
  end

  it 'should show notes on info page' do
    n = Note.create(body: 'some text')
    pc = category.person_categories.first
    mt = MoneyTransaction.create(count:100, note: n, important:true, person_category: pc)
    get category_info_path(mt.person_category.category)
    expect(response.body).to include('Note')
  end

  it 'should get edit page of note' do
    n = Note.create(body: 'some text')
    pc = category.person_categories.first
    MoneyTransaction.create(count:100, note: n, important:true, person_category: pc)
    get edit_note_path(n)
    expect(response.body).to include('Update note')
  end

  it 'should not show note on info page for another user ' do
    n = Note.create(body: 'some text')
    pc = category.person_categories.first
    mt = MoneyTransaction.create(count:100, note: n, important:true, person_category: pc)
    sign_out user
    sign_in User.create(email: 'fsfsdffsf@fsdf.sdf, password: fsdfsdf')
    get category_info_path(mt.person_category.category)
    expect(response.body).to include('example')
  end

  it 'should not get edit page for another user' do
    n = Note.create(body: 'some text')
    pc = category.person_categories.first
    MoneyTransaction.create(count:100, note: n, important:true, person_category: pc)
    sign_out user
    sign_in User.create(email: 'fsfsdffsf@fsdf.sdf, password: fsdfsdf')
    get edit_note_path(n)
    expect(response.body).to include('example')
  end
end
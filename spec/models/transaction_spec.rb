require 'rails_helper'

RSpec.describe MoneyTransaction, type: :model do
  let!(:user) do
    User.create(email: 'user_category@gmail.com', password: '123456', password_confirmation: '123456')
  end

  let!(:person) { Person.create(first_name: 'Justin', last_name: 'Mur', description: 'son', user_id: user.id) }

  it { should validate_presence_of :count }

  it 'should create new transaction' do
    person.categories << Category.create(title: 'clothes')
    MoneyTransaction.create(count: 130, person_category_id: person.person_categories.first.id)
    expect(person.person_categories.first.money_transactions).to be_truthy
  end

  it 'should delete transaction' do
    person.categories << Category.create(title: 'car')
    transaction = MoneyTransaction.create(count: 80, person_category_id: person.person_categories.first.id)
    expect { transaction.destroy }.to change(MoneyTransaction, :count).by(-1)
  end
end

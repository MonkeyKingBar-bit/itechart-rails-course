require 'rails_helper'

RSpec.describe "transactions/new", type: :view do
  before(:each) do
    assign(:transaction, Transaction.new(
      amountValue: 1,
      personCategoryId: 1
    ))
  end

  it "renders new transaction form" do
    render

    assert_select "form[action=?][method=?]", transactions_path, "post" do

      assert_select "input[name=?]", "transaction[amountValue]"

      assert_select "input[name=?]", "transaction[personCategoryId]"
    end
  end
end

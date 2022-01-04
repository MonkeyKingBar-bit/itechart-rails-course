require 'rails_helper'

RSpec.describe "notes/index", type: :view do
  before(:each) do
    assign(:notes, [
      Note.create!(
        body: "Body"
      ),
      Note.create!(
        body: "Body"
      )
    ])
  end

  it "renders a list of notes" do
    render
    assert_select "tr>td", text: "Body".to_s, count: 2
  end
end

require 'rails_helper'

RSpec.describe "notes/show", type: :view do
  before(:each) do
    @note = assign(:note, Note.create!(
      body: "Body"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Body/)
  end
end

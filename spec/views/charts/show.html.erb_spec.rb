require 'rails_helper'

RSpec.describe "charts/show", type: :view do
  before(:each) do
    @chart = assign(:chart, Chart.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end

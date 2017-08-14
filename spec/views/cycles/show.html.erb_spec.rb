require 'rails_helper'

RSpec.describe "cycles/show", type: :view do
  before(:each) do
    @cycle = assign(:cycle, Cycle.create!(
      :name => "Name",
      :budget => 2.5,
      :project => nil,
      :organization => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end

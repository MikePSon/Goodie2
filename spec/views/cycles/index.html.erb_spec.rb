require 'rails_helper'

RSpec.describe "cycles/index", type: :view do
  before(:each) do
    assign(:cycles, [
      Cycle.create!(
        :name => "Name",
        :budget => 2.5,
        :project => nil,
        :organization => nil
      ),
      Cycle.create!(
        :name => "Name",
        :budget => 2.5,
        :project => nil,
        :organization => nil
      )
    ])
  end

  it "renders a list of cycles" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end

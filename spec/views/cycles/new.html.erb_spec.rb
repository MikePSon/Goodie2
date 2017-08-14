require 'rails_helper'

RSpec.describe "cycles/new", type: :view do
  before(:each) do
    assign(:cycle, Cycle.new(
      :name => "MyString",
      :budget => 1.5,
      :project => nil,
      :organization => nil
    ))
  end

  it "renders new cycle form" do
    render

    assert_select "form[action=?][method=?]", cycles_path, "post" do

      assert_select "input#cycle_name[name=?]", "cycle[name]"

      assert_select "input#cycle_budget[name=?]", "cycle[budget]"

      assert_select "input#cycle_project_id[name=?]", "cycle[project_id]"

      assert_select "input#cycle_organization_id[name=?]", "cycle[organization_id]"
    end
  end
end

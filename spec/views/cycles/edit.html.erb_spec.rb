require 'rails_helper'

RSpec.describe "cycles/edit", type: :view do
  before(:each) do
    @cycle = assign(:cycle, Cycle.create!(
      :name => "MyString",
      :budget => 1.5,
      :project => nil,
      :organization => nil
    ))
  end

  it "renders the edit cycle form" do
    render

    assert_select "form[action=?][method=?]", cycle_path(@cycle), "post" do

      assert_select "input#cycle_name[name=?]", "cycle[name]"

      assert_select "input#cycle_budget[name=?]", "cycle[budget]"

      assert_select "input#cycle_project_id[name=?]", "cycle[project_id]"

      assert_select "input#cycle_organization_id[name=?]", "cycle[organization_id]"
    end
  end
end

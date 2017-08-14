require 'rails_helper'

RSpec.describe "projects/new", type: :view do
  before(:each) do
    assign(:project, Project.new(
      :name => "MyString",
      :annual_budget => "MyString",
      :organization => nil
    ))
  end

  it "renders new project form" do
    render

    assert_select "form[action=?][method=?]", projects_path, "post" do

      assert_select "input#project_name[name=?]", "project[name]"

      assert_select "input#project_annual_budget[name=?]", "project[annual_budget]"

      assert_select "input#project_organization_id[name=?]", "project[organization_id]"
    end
  end
end

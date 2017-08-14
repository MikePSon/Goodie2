require 'rails_helper'

RSpec.describe "projects/edit", type: :view do
  before(:each) do
    @project = assign(:project, Project.create!(
      :name => "MyString",
      :annual_budget => "MyString",
      :organization => nil
    ))
  end

  it "renders the edit project form" do
    render

    assert_select "form[action=?][method=?]", project_path(@project), "post" do

      assert_select "input#project_name[name=?]", "project[name]"

      assert_select "input#project_annual_budget[name=?]", "project[annual_budget]"

      assert_select "input#project_organization_id[name=?]", "project[organization_id]"
    end
  end
end

require 'rails_helper'

RSpec.describe "requests/edit", type: :view do
  before(:each) do
    @request = assign(:request, Request.create!(
      :name => "MyString",
      :cycle => "",
      :project => nil,
      :organization => nil
    ))
  end

  it "renders the edit request form" do
    render

    assert_select "form[action=?][method=?]", request_path(@request), "post" do

      assert_select "input#request_name[name=?]", "request[name]"

      assert_select "input#request_cycle[name=?]", "request[cycle]"

      assert_select "input#request_project_id[name=?]", "request[project_id]"

      assert_select "input#request_organization_id[name=?]", "request[organization_id]"
    end
  end
end

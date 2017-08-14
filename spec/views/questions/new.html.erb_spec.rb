require 'rails_helper'

RSpec.describe "questions/new", type: :view do
  before(:each) do
    assign(:question, Question.new(
      :label => "MyString",
      :cycle => nil,
      :project => nil,
      :organization => nil
    ))
  end

  it "renders new question form" do
    render

    assert_select "form[action=?][method=?]", questions_path, "post" do

      assert_select "input#question_label[name=?]", "question[label]"

      assert_select "input#question_cycle_id[name=?]", "question[cycle_id]"

      assert_select "input#question_project_id[name=?]", "question[project_id]"

      assert_select "input#question_organization_id[name=?]", "question[organization_id]"
    end
  end
end

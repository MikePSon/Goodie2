require 'rails_helper'

RSpec.describe "release_notes/new", type: :view do
  before(:each) do
    assign(:release_note, ReleaseNote.new(
      :note => "MyString"
    ))
  end

  it "renders new release_note form" do
    render

    assert_select "form[action=?][method=?]", release_notes_path, "post" do

      assert_select "input#release_note_note[name=?]", "release_note[note]"
    end
  end
end

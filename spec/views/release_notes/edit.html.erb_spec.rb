require 'rails_helper'

RSpec.describe "release_notes/edit", type: :view do
  before(:each) do
    @release_note = assign(:release_note, ReleaseNote.create!(
      :note => "MyString"
    ))
  end

  it "renders the edit release_note form" do
    render

    assert_select "form[action=?][method=?]", release_note_path(@release_note), "post" do

      assert_select "input#release_note_note[name=?]", "release_note[note]"
    end
  end
end

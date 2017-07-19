require 'rails_helper'

RSpec.describe "release_notes/index", type: :view do
  before(:each) do
    assign(:release_notes, [
      ReleaseNote.create!(
        :note => "Note"
      ),
      ReleaseNote.create!(
        :note => "Note"
      )
    ])
  end

  it "renders a list of release_notes" do
    render
    assert_select "tr>td", :text => "Note".to_s, :count => 2
  end
end

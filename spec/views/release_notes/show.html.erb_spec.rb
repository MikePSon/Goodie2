require 'rails_helper'

RSpec.describe "release_notes/show", type: :view do
  before(:each) do
    @release_note = assign(:release_note, ReleaseNote.create!(
      :note => "Note"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Note/)
  end
end

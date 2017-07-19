require 'rails_helper'

RSpec.describe "ReleaseNotes", type: :request do
  describe "GET /release_notes" do
    it "works! (now write some real specs)" do
      get release_notes_path
      expect(response).to have_http_status(200)
    end
  end
end

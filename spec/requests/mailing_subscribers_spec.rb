require 'rails_helper'

RSpec.describe "MailingSubscribers", type: :request do
  describe "GET /mailing_subscribers" do
    it "works! (now write some real specs)" do
      get mailing_subscribers_path
      expect(response).to have_http_status(200)
    end
  end
end

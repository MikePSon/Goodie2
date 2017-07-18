require "rails_helper"

RSpec.describe MailingSubscribersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/mailing_subscribers").to route_to("mailing_subscribers#index")
    end

    it "routes to #new" do
      expect(:get => "/mailing_subscribers/new").to route_to("mailing_subscribers#new")
    end

    it "routes to #show" do
      expect(:get => "/mailing_subscribers/1").to route_to("mailing_subscribers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/mailing_subscribers/1/edit").to route_to("mailing_subscribers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/mailing_subscribers").to route_to("mailing_subscribers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/mailing_subscribers/1").to route_to("mailing_subscribers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/mailing_subscribers/1").to route_to("mailing_subscribers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/mailing_subscribers/1").to route_to("mailing_subscribers#destroy", :id => "1")
    end

  end
end

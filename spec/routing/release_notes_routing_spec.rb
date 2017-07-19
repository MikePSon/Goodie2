require "rails_helper"

RSpec.describe ReleaseNotesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/release_notes").to route_to("release_notes#index")
    end

    it "routes to #new" do
      expect(:get => "/release_notes/new").to route_to("release_notes#new")
    end

    it "routes to #show" do
      expect(:get => "/release_notes/1").to route_to("release_notes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/release_notes/1/edit").to route_to("release_notes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/release_notes").to route_to("release_notes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/release_notes/1").to route_to("release_notes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/release_notes/1").to route_to("release_notes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/release_notes/1").to route_to("release_notes#destroy", :id => "1")
    end

  end
end

require "spec_helper"

describe AlternativesController do
  describe "routing" do

    it "routes to #index" do
      get("/alternatives").should route_to("alternatives#index")
    end

    it "routes to #new" do
      get("/alternatives/new").should route_to("alternatives#new")
    end

    it "routes to #show" do
      get("/alternatives/1").should route_to("alternatives#show", :id => "1")
    end

    it "routes to #edit" do
      get("/alternatives/1/edit").should route_to("alternatives#edit", :id => "1")
    end

    it "routes to #create" do
      post("/alternatives").should route_to("alternatives#create")
    end

    it "routes to #update" do
      put("/alternatives/1").should route_to("alternatives#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/alternatives/1").should route_to("alternatives#destroy", :id => "1")
    end

  end
end

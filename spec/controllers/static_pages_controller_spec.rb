require 'spec_helper'

describe StaticPagesController do

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'groups'" do
    it "returns http success" do
      get 'groups'
      response.should be_success
    end
  end

  describe "GET 'projects'" do
    it "returns http success" do
      get 'projects'
      response.should be_success
    end
  end

end

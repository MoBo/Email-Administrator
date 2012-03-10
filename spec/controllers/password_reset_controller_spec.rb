require 'spec_helper'

describe PasswordResetController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'update'" do
    it "returns http success" do
      get 'update'
      response.should be_success
    end
  end
  
  describe "After filling Reset email form" do
    it "should show that reset email is send" do
      
    end
    it "should save :reset_password_token in database" do
      
    end
  end

end

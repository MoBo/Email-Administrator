require 'spec_helper'

describe ResetPasswordsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end
  
  describe "GET 'create'" do
    before do
      @email = Factory(:email)
    end
    it "should be redirected" do
      post 'create', {:email_address => @email.email}
      response.should redirect_to(reset_passwords_path)
      flash[:notice].should eq "Email is sent, check you inbox"
    end
    it "should have error if no email is provided" do
      post 'create', {}
      response.should redirect_to(reset_passwords_path)
      flash[:error].should eq "Email not found"
    end
     it "should have error if false email is provided" do
      post 'create', {:email_address => "xxxxxx"}
      response.should redirect_to(reset_passwords_path)
      flash[:error].should eq "Email not found"
    end
  end
  
  describe "After filling Reset email form" do
    it "should show that reset email is send" do
      
    end
    it "should save :reset_password_token in database" do
      
    end
  end

end

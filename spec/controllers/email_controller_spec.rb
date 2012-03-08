require 'spec_helper'

describe EmailsController do
  
  before :each do 
    @attr = {:email => "hallo@google.lt", :password => "testmeplease" };
  end
  
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  # describe "GET 'edit'" do
    # it "returns http success" do
      # get 'edit'
      # response.should be_success
    # end
  # end
# 
  # describe "GET 'update'" do
    # it "returns http success" do
      # get 'update'
      # response.should be_success
    # end
  # end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  # describe "GET 'create'" do
    # it "returns http success" do
      # get 'create'
      # response.should be_success
    # end
  # end
  
  describe "Email can be created" do
    it "if password is provided" do
      email = Email.create(@attr)
      email.should be_valid
    end
  end
  
  describe "Email can be created" do
    before do 
      @email = Factory(:email)
      @send_email = @email.send_reset_password_instructions
      @token = @email.reset_password_token
    end
    it "and token is in email" do
      @send_email.body.include?(@token).should be_true
    end
    it "and token is in db" do
      @email.reset_password_token.should_not nil
    end
  end
  
    describe "Email to reset the password " do
    it "should be sent if email expires" do
      
    end
    it "should be resend if token expired" do
      
    end
    
  end
  
  describe "Email should contain" do
    it "equal token as in datase" do
      
    end
  end

end

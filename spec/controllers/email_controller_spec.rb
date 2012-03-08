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
  
  describe "Email expires soon" do
    before do
      @email_expires_in_two_days = Factory(:email_expires_in_two_days)
      @email_expires_reminder_send = Factory(:email_expires_reminder_send)
    end
    let(:emails)  {Email.get_emails_expires_soon}
    let(:emails_are_expired)  {Email.get_emails_expired}
    
    it "and should contains email which expires soon" do
      emails.to_a.include?(@email_expires_in_two_days).should be_true    
    end 
    
    it "and should not contains email for which a reminder was already sent" do
      emails.to_a.include?(@email_expires_reminder_send).should_not be_true
    end
    
    # Normally reminder email should be sent, but include in the test case
    it "and emails are marked as reminded" do
      emails.empty?.should be_false 
      emails.each do |email|
        email.set_reminder_send(true);
      end
      
      emails.each do |email|
        email.reminder_send.should be_true 
      end
    end
    
    it "and deactivate email when it is expired" do
      emails_are_expired.empty?.should be_false
       
      emails_are_expired.each do |email|
        email.deactivate
      end
      
      emails_are_expired.each do |email|
        email.active.should be_false
      end
      
    end
    
    
  end
  
end

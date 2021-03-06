require 'spec_helper'

describe EmailsController do
  
  before :each do
    @admin_domain = Factory(:admin_domain)
    @admin = Factory(:admin)
    sign_in :email, @admin
    @domain = Factory(:domain) 
    @email = Factory(:email)
  end
  
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
  
  describe "Email can be updated" do
    describe "if password is not provided" do
      before { @email.password = "";@email.password_confirmation =""}
      it{@email.should be_valid}
    end
  end
  
  describe "Email can be updated" do
    before do 
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
      @email_expired = Factory(:email_expired)
      @emails_are_expiring_soon = Email.get_emails_expires_soon
      @emails_are_expired = Email.get_emails_expired
    end
    #let(:emails)  {Email.get_emails_expires_soon}
    #let(:emails_are_expired)  {Email.get_emails_expired}
    
    it "and should contains email which expires soon" do
      @emails_are_expiring_soon[0].email.should eql @email_expires_in_two_days.email
      @emails_are_expiring_soon.count.should be == 1    
    end 
    
    it "and should not contains email for which a reminder was already sent" do
      @emails_are_expiring_soon.count.should be == 1   
      @emails_are_expiring_soon[0].email.should_not eql @email_expires_reminder_send.email
    end
    
    # Normally reminder email should be sent, but include in the test case
    it "and emails are marked as reminded" do
      @emails_are_expiring_soon.empty?.should be_false 
      @emails_are_expiring_soon.each do |email|
        email.set_reminder_sent(true);
      end
      
      @emails_are_expiring_soon.each do |email|
        email.reminder_sent.should be_true 
      end
    end
    
    it "and deactivate email when it is expired" do
      @emails_are_expired.empty?.should be_false
       
      @emails_are_expired.each do |email|
        email.deactivate
      end
      
      @emails_are_expired.each do |email|
        email.active.should be_false
      end
      
    end
    
    
  end
  
end

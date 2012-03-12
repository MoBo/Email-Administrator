require "spec_helper"

describe Email do
  before do 
    @email = Factory(:email)
  end
  
  subject { @email }
  
  it {should respond_to(:email)}
  it {should respond_to(:encrypted_password)}
  it {should respond_to(:comment)}
  it {should respond_to(:expires)}
  it {should respond_to(:email_path_id)}
  it {should respond_to(:domain_id)}
  it {should respond_to(:forward_email)}
  it {should respond_to(:receive)}
  it {should respond_to(:alt_email)}
  it {should respond_to(:reminder_send)}
  it {should respond_to(:active)}
  it {should respond_to(:reset_password_token)}
  it {should respond_to(:reset_password_sent_at)}
  
  it {should be_valid }
  
  describe "editing email adress" do
   it "saving emtpy domain id should raise exception" do
     e = @email.domain
     e = nil
     e.should raise_error
   end
    
    describe "setting domain name, should also email adress be changed" do
      before do
        @domain = Domain.create(:name => "heise.de")
        @email_address_before = @email.email;
        @email.domain = @domain
        @email.save
        @email_address_after = @email.email       
      end
      it {@email_address_before.should_not match @email_address_after}
    end    
  end
  describe "Password reset"
    describe "should have an reset_password_token if reminder_send is set" do
      
    end
    
    describe "should have reset_password_sent_at if reminder is send" do
      
    end
    
    describe "should not be possible to reset_password if reset_password_send_at later then configured value" do
      
    end
  end

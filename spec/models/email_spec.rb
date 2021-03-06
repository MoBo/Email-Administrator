require "spec_helper"

describe Email do
  before do
    @domain = Factory(:domain) 
    @email = Email.new(email: "user@heise.de",
    password: "foobar", password_confirmation: "foobar", domain_id: @domain.id, email_path: '/var/logs', reminder_sent: false, expires_on: Time.now + 50.days, alt_email: "moritz.bode@gmail.com")
  end
  
  subject { @email }
  
  it {should respond_to(:email)}
  it {should respond_to(:encrypted_password)}
  it {should respond_to(:comment)}
  it {should respond_to(:expires_on)}
  it {should respond_to(:email_path)}
  it {should respond_to(:domain_id)}
  it {should respond_to(:forward_email)}
  it {should respond_to(:can_receive)}
  it {should respond_to(:can_send)}
  it {should respond_to(:alt_email)}
  it {should respond_to(:reminder_sent)}
  it {should respond_to(:active)}
  it {should respond_to(:reset_password_token)}
  it {should respond_to(:reset_password_sent_at)}
  
  it {@email.should be_valid }
  
  describe "new email address" do
    
    
    
    
    describe "Email cant be created" do
      describe "if password is not provided" do
       before { @email_temp = Email.new(email: "user@heise.de",
    password: "", password_confirmation: "", domain_id: @domain.id, email_path: '/var/logs')}
       it{@email_temp.should_not be_valid}
      end
    end
    
    describe "and empty email address" do
      before{@email.email = ""}
      it{@email.should_not be_valid}
    end
    
    # Since the email just prefix should be given, ignore these tests
     
    #describe "and invalid email address witdh @@" do
      # before{@email.email = "ich@ich@sauli.de"}
      # it{@email.should_not be_valid}
    # end
#     
    # describe "and invalid forward address with double @" do
      # before{@email.forward_email = "ich@@sauli.de"}
      # it{@email.should_not be_valid}
    # end
#     
    # # describe "and empty alt_email adresse" do
      # # before{@email.alt_email = nil}
      # # it{@email.should_not be_valid}
    # # end
#     
    # describe "and invalid alt_email address" do
      # before{@email.alt_email = "ich@@@@@@sauli.de"}
      # it{@email.should_not be_valid}
    # end
    
    describe "and empty email_path" do
      before{@email.email_path = nil}
      it{@email.should_not be_valid}
    end
    
    describe "and blank email_path" do
      before{@email.email_path = ""}
      it{@email.should_not be_valid}
    end
    
    describe "and empty domain_id" do
      before{@email.domain_id = nil}
      it{@email.should raise_error}
    end
    
    describe "and unvalid domain_id" do
      before{@email.domain_id = "5"}
      it{@email.should raise_error}
    end
    
    describe "and expire date and without alternative email" do
      before{
        @email.expires_on = Date.today
        @email.alt_email = ""
        }
      it{@email.should_not be_valid}
    end
  end
  
  
  describe "editing email adress" do
    describe "setting domain name, should also email adress be changed" do
      before do
        @domain = Domain.create(:name => "test.de")
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

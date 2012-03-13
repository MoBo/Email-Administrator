require 'spec_helper'

describe Admin do
  before do
    @admin = Admin.new(email: "ich@sauli.de", 
    password: "foobar", password_confirmation: "foobar")
  end
  
  subject { @admin }
  
  it {should respond_to(:email)}
  it {should respond_to(:encrypted_password)}
  
  it {@admin.should be_valid }
  
  describe "new admin" do
    
    describe "and empty email adresse" do
      before{@admin.email = ""}
      it{@admin.should_not be_valid}
    end
    
    describe "and empty email adresse (nil)" do
      before{@admin.email = nil}
      it{@admin.should_not be_valid}
    end
    
    describe "and unvalid email adresse" do
      before{@admin.email = "ich@@@@sauli.de"}
      it{@admin.should_not be_valid}
    end
    
  end
end

require "spec_helper"

describe Domain do
  before do
    @domain = Domain.new(name: "foobar.de")
  end
   
  subject { @domain }
   
  it {should respond_to(:name)}
  
  it {@domain.should be_valid }
  
  describe "new domain" do
    describe "and with empty name" do
      before{@domain.name = nil}
      it {@domain.should_not be_valid}
    end
    
    describe "and with invalid name (email address)" do
      before{@domain.name = "sdfsdf@sdfsdf.de"}
      it {@domain.should_not be_valid}
    end
     
    describe "and with invalid name (not valid domain)" do
      before{@domain.name = "sdfsdf"}
      it {@domain.should_not be_valid}
    end
  end
  
end

require 'spec_helper'

describe "Email pages" do
  
  subject { page }
  
  before{
    @email_path  = Factory(:email_path)
    @example_email = Factory(:email)
  }
  
  describe "new page" do
    before { visit new_email_path }
    
    it { find_field('email_path_name').value.should eql 'var/logs' }
  end
  
  describe "edit page" do
    before {
      
      visit edit_email_path(@example_email) }
    
    it { find_field('email_path_name').value.should eql 'var/logs' }
  end
  
  describe "new" do
    
    before { visit new_email_path }
 
    describe "with default path" do
      
      it "should create a new emails_path" do
        expect { click_button "Create Email" }.not_to change(EmailPath, :count)
      end
    end
    
    describe "with new path" do
      before do
        fill_in "email_path_name",         with: "test"
      end
      
      it "should create a new emails_path" do
        expect { click_button "Create Email" }.to change(EmailPath, :count)
      end
    end
    
    describe "with empty path" do
      before do
        fill_in "email_path_name",         with: ""
      end
      
      it "should create a new emails_path" do
        expect { click_button "Create Email" }.not_to change(EmailPath, :count)
      end
    end
  end
  
  describe "edit" do
    
    before { 
      
      visit edit_email_path(@example_email) }
 
    describe "with default path" do
      
      it "should create a new emails_path" do
        expect { click_button "Update Email" }.not_to change(EmailPath, :count)
      end
    end
    
    describe "with new path" do
      before do
        fill_in "email_path_name",         with: "test"
      end
      
      it "should create a new emails_path" do
        expect { click_button "Update Email" }.to change(EmailPath, :count)
      end
    end
    
    describe "with empty path" do
      before do
        fill_in "email_path_name",         with: ""
      end
      
      it "should create a new emails_path" do
        expect { click_button "Update Email" }.not_to change(EmailPath, :count)
      end
    end
  end
end
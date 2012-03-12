require 'spec_helper'

describe "Email pages" do
  
  subject { page }
  
  before{
    @domains = Array.new
    
    10.times {
      @domains.push(Factory.create :domain_seq)
    }
    
    
    @email_path  = Factory(:email_path)
    @example_email = Factory(:email)
    
    
  }
  
  it "should have 10 domains" do
    Domain.count.should be == 10
  end
  
  describe "new page" do
    before { visit new_email_path }
    
    it { find_field('email_path_name').value.should eql 'var/logs' }
  end
  
  describe "edit page" do
    before {
      
      visit edit_email_path(@example_email) }
    
    it { find_field('email_path_name').value.should eql 'var/logs' }
    
    it {page.has_select?('email_domain_id', :selected => @example_email.domain.name).should be_true}
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
    
    describe "select second domain" do
      before do
        select(@domains[1].name, :from => 'email_domain_id')
        click_button("Create Email")
      end
      
      it "should be the second domain accosiated with the new email" do
        Email.last.domain.id.should be == 2
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
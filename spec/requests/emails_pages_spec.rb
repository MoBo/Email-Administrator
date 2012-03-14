require 'spec_helper'

describe "Email pages" do
  
  subject { page }
  
  before{
    @admin = Factory(:admin)
    visit admin_session_path
    fill_in "admin_email",  with: @admin.email
    fill_in "admin_password",         with: @admin.password
    click_button "Sign in"
    
    @domains = Array.new
    
    10.times {
      @domains.push(Factory.create :domain_seq)
    }
    
    @example_email = Factory(:email)
  }
  
  it "should have 10 domains" do
    Domain.count.should be == 10
  end
  
  describe "new page" do
    before { visit new_email_path }
    
    it { find_field('email[email_path]').value.should eql 'var/logs/' }
  end
  
  describe "edit page" do
    before { 
      visit edit_email_path(@example_email) }
    
    it { find_field('email[email_path]').value.should eql 'var/logs/' }
    
    it {page.has_select?('email_domain_id', :selected => @example_email.domain.name).should be_true}
  end
  
  describe "edit" do
    
    before { 
      
    visit edit_email_path(@example_email) }
 
    
    describe "with new path" do
      before do
        fill_in "email[email_path]",  with: "test"
        click_button "Update Email"
      end
      
      it "should create a new emails_path" do
        #todo rewrite test
        # @example_email.should be_valid
        # @example_email.email_path.should eql "test"
      end
    end
    
  end

end